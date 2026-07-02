# Buscar SRs en correos de Outlook
# Patrones: "SR - 4-XXXXXXXXXX", "SR 4-XXXXXXXXXX", "4-XXXXXXXXXX", o número suelto de 10 dígitos
# Usa ultimo.txt para saber desde cuándo buscar

$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")

# Patron 1: "SR - 4-XXXXXXXXXX", "SR 4-XXXXXXXXXX", "4-XXXXXXXXXX"
$patternSR = '(?:SR\s*[-]?\s*)?4-(\d{10})'
# Patron 2: número suelto de 10 dígitos (no precedido ni seguido de otro dígito o guión)
$patternSolo = '(?<![\d-])\b(\d{10})\b(?![\d-])'

# Leer fecha desde ultimo.txt, si no existe usar ayer
$basePath = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$ultimoPath = Join-Path $basePath "ultimo.txt"
if (Test-Path $ultimoPath) {
    $fechaDesde = Get-Date (Get-Content $ultimoPath -First 1).Trim()
    Write-Host "Usando fecha desde ultimo.txt: $($fechaDesde.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow
} else {
    $fechaDesde = (Get-Date).AddDays(-1).Date
    Write-Host "No se encontro ultimo.txt, buscando desde ayer." -ForegroundColor Yellow
}
$fechaHasta = Get-Date

$resultados = @{}  # Hashtable: SR -> objeto con fecha más antigua
$carpetasBuscadas = @()

# Tipos de carpeta que contienen correos (excluir Calendar, Contacts, Tasks, Notes, Journal)
$tiposMail = @(0, 1, 2, 3, 4, 5, 6, 23, 25)  # olFolderInbox, olFolderSentMail, etc.

function Es-CarpetaMail {
    param($carpeta)
    try {
        $tipo = $carpeta.DefaultItemType
        # 0 = olMailItem, solo buscar en carpetas de correo
        return ($tipo -eq 0)
    } catch {
        return $false
    }
}

function Buscar-EnCarpeta {
    param($carpeta, $nivel = 0, $forzar = $false)

    $nombreCarpeta = try { $carpeta.Name } catch { "Desconocida" }
    $indent = "  " * $nivel

    # Solo buscar en carpetas que contienen correos
    $esMail = Es-CarpetaMail $carpeta
    if (-not $esMail -and -not $forzar) {
        # Silenciosamente saltar carpetas que no son de correo
        return
    }

    Write-Host "${indent}Buscando en: $nombreCarpeta ..." -ForegroundColor Cyan

    try {
        $items = $carpeta.Items
        $items.Sort("[ReceivedTime]", $true)  # Más recientes primero
        $count = $items.Count
        $mailsEnRango = 0

        for ($i = 1; $i -le $count; $i++) {
            try {
                $mail = $items.Item($i)
                if ($mail.Class -ne 43) { continue }  # 43 = olMail

                $fecha = $mail.ReceivedTime
                # Saltar correos futuros
                if ($fecha -gt (Get-Date)) { continue }
                # Parar cuando pasamos del rango (ordenados desc)
                if ($fecha -lt $fechaDesde) { break }

                $mailsEnRango++
                $asunto = $mail.Subject
                $cuerpo = $mail.Body
                $textoCompleto = "$asunto $cuerpo"

                # Recolectar todos los SRs encontrados en este correo
                $srsEncontrados = @{}

                # Buscar patron con "SR" y/o "4-"
                $matchesSR = [regex]::Matches($textoCompleto, $patternSR, 'IgnoreCase')
                foreach ($m in $matchesSR) {
                    $numero = $m.Groups[1].Value
                    $srsEncontrados["SR 4-$numero"] = $true
                }

                # Buscar números sueltos de 10 dígitos
                $matchesSolo = [regex]::Matches($textoCompleto, $patternSolo)
                foreach ($m in $matchesSolo) {
                    $numero = $m.Groups[1].Value
                    $srsEncontrados["SR 4-$numero"] = $true
                }

                # Guardar solo el correo más antiguo por SR
                foreach ($srCompleto in $srsEncontrados.Keys) {
                    if (-not $script:resultados.ContainsKey($srCompleto) -or $fecha -lt $script:resultados[$srCompleto].FechaObj) {
                        $script:resultados[$srCompleto] = [PSCustomObject]@{
                            SR       = $srCompleto
                            Fecha    = $fecha.ToString("yyyy-MM-dd HH:mm")
                            FechaObj = $fecha
                            Asunto   = $asunto
                            Carpeta  = $nombreCarpeta
                        }
                    }
                }
            } catch {
                # Ignorar correos que no se pueden leer
            }
        }

        if ($mailsEnRango -gt 0) {
            Write-Host "${indent}  -> $mailsEnRango correos en rango de fechas" -ForegroundColor Gray
            $script:carpetasBuscadas += "$nombreCarpeta ($mailsEnRango correos)"
        }
    } catch {
        # Solo mostrar error si era una carpeta de correo
        if ($esMail) {
            Write-Host "${indent}  -> Error: $_" -ForegroundColor Yellow
        }
    }

    # Buscar recursivamente en subcarpetas
    try {
        for ($j = 1; $j -le $carpeta.Folders.Count; $j++) {
            Buscar-EnCarpeta $carpeta.Folders.Item($j) ($nivel + 1)
        }
    } catch {}
}

Write-Host "========================================" -ForegroundColor Green
Write-Host " Buscador de SRs en Outlook" -ForegroundColor Green
Write-Host " Rango: $($fechaDesde.ToString('dd-MMM-yyyy')) a $(Get-Date -Format 'dd-MMM-yyyy')" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# =============================================
# PASO 1: Buscar en todas las cuentas normales
# =============================================
for ($s = 1; $s -le $namespace.Folders.Count; $s++) {
    $store = $namespace.Folders.Item($s)
    Write-Host "`nCuenta: $($store.Name)" -ForegroundColor Yellow
    Write-Host ("-" * 50) -ForegroundColor Yellow
    Buscar-EnCarpeta $store
}

# =============================================
# PASO 2: Buscar en Grupos de Microsoft 365
# =============================================
Write-Host ""
Write-Host "========================================" -ForegroundColor Magenta
Write-Host " Buscando en Grupos de Microsoft 365..." -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta

$gruposEncontrados = 0

# Método 1: Buscar stores que contengan "Nivel2" o "SoporteOracle" en el nombre
for ($s = 1; $s -le $namespace.Stores.Count; $s++) {
    try {
        $store = $namespace.Stores.Item($s)
        $storeName = $store.DisplayName
        Write-Host "  Store encontrado: $storeName" -ForegroundColor Gray

        if ($storeName -match "Nivel2|SoporteOracle|Soporte.*Oracle") {
            Write-Host "  >> GRUPO ENCONTRADO: $storeName" -ForegroundColor Green
            $gruposEncontrados++
            $root = $store.GetRootFolder()
            Buscar-EnCarpeta $root 1 $true

            # Buscar subcarpetas del grupo
            try {
                for ($f = 1; $f -le $root.Folders.Count; $f++) {
                    $subFolder = $root.Folders.Item($f)
                    Buscar-EnCarpeta $subFolder 2 $true
                }
            } catch {}
        }
    } catch {}
}

# Método 2: Buscar carpeta "Grupos" dentro de cada cuenta
if ($gruposEncontrados -eq 0) {
    Write-Host ""
    Write-Host "  No se encontró como Store separado. Buscando como subcarpeta..." -ForegroundColor Gray

    for ($s = 1; $s -le $namespace.Folders.Count; $s++) {
        $store = $namespace.Folders.Item($s)
        try {
            for ($f = 1; $f -le $store.Folders.Count; $f++) {
                $folder = $store.Folders.Item($f)
                $fname = $folder.Name
                if ($fname -match "Grupo|Group|Nivel2|SoporteOracle") {
                    Write-Host "  >> Carpeta encontrada: $fname (en $($store.Name))" -ForegroundColor Green
                    $gruposEncontrados++
                    Buscar-EnCarpeta $folder 2 $true

                    # Buscar dentro
                    try {
                        for ($g = 1; $g -le $folder.Folders.Count; $g++) {
                            $sub = $folder.Folders.Item($g)
                            Buscar-EnCarpeta $sub 3 $true
                        }
                    } catch {}
                }
            }
        } catch {}
    }
}

if ($gruposEncontrados -eq 0) {
    Write-Host ""
    Write-Host "  AVISO: No se pudo acceder al grupo Nivel2_SoporteOracle via COM." -ForegroundColor Red
    Write-Host "  Los Grupos de M365 a veces no son accesibles por COM/PowerShell." -ForegroundColor Red
    Write-Host "  Los correos del grupo que llegan a tu Inbox SI fueron revisados." -ForegroundColor Yellow
}

# =============================================
# RESULTADOS
# =============================================
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host " CARPETAS REVISADAS CON CORREOS" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
foreach ($c in $carpetasBuscadas) {
    Write-Host "  - $c" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host " RESULTADOS" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$csvPath = Join-Path $basePath "resultados_sr_outlook.csv"
$oldPath = Join-Path $basePath "old.csv"

# Si ya existe un CSV anterior, renombrarlo a old.csv
if (Test-Path $csvPath) {
    Copy-Item -Path $csvPath -Destination $oldPath -Force
    Write-Host "CSV anterior guardado como old.csv" -ForegroundColor Yellow
}

if ($resultados.Count -eq 0) {
    Write-Host "No se encontraron SRs en el rango de fechas." -ForegroundColor Red
} else {
    # Cargar SRs del old.csv para comparar
    $srsOld = @{}
    if (Test-Path $oldPath) {
        Import-Csv $oldPath | ForEach-Object { $srsOld[$_.SR] = $true }
    }

    # Convertir hashtable a lista, agregar columna New, ordenar por SR
    $listaResultados = $resultados.Values | Sort-Object SR | ForEach-Object {
        $esNuevo = -not $srsOld.ContainsKey($_.SR)
        [PSCustomObject]@{
            SR     = $_.SR
            New    = if ($esNuevo) { "true" } else { "" }
            Fecha  = $_.Fecha
            Asunto = $_.Asunto
            Carpeta = $_.Carpeta
        }
    }

    $nuevos = @($listaResultados | Where-Object { $_.New -eq "true" })
    Write-Host "SRs unicos encontrados: $($listaResultados.Count)" -ForegroundColor Cyan
    if ($nuevos.Count -gt 0) {
        Write-Host "SRs NUEVOS (no estaban en old.csv): $($nuevos.Count)" -ForegroundColor Green
    }
    Write-Host ""

    # Mostrar tabla
    $listaResultados | Format-Table -AutoSize -Wrap

    # Exportar a CSV
    $listaResultados | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
    Write-Host "Resultados exportados a: $csvPath" -ForegroundColor Green

    # Listado simple
    Write-Host ""
    Write-Host "--- LISTADO DE SRs ---" -ForegroundColor Cyan
    foreach ($r in $listaResultados) {
        $tag = if ($r.New -eq "true") { " ** NUEVO **" } else { "" }
        $color = if ($r.New -eq "true") { "Green" } else { "White" }
        Write-Host "  $($r.SR)$tag" -ForegroundColor $color
    }
}

# Guardar timestamp en ultimo.txt
$fechaHasta.ToString("yyyy-MM-dd HH:mm:ss") | Out-File -FilePath $ultimoPath -Encoding UTF8 -Force
Write-Host ""
Write-Host "Fecha guardada en ultimo.txt: $($fechaHasta.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Green
Write-Host "Listo." -ForegroundColor Green
