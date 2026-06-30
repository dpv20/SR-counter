# Buscar SRs en correos de Outlook via Microsoft Graph API (nuevo Outlook)
# Patrones: "SR - 4-XXXXXXXXXX", "SR 4-XXXXXXXXXX", "4-XXXXXXXXXX", o numero suelto de 10 digitos
# Usa ultimo.txt para saber desde cuando buscar

# --- Verificar e instalar modulo Microsoft.Graph ---
$modulos = @("Microsoft.Graph.Authentication", "Microsoft.Graph.Mail")
foreach ($mod in $modulos) {
    if (-not (Get-Module -ListAvailable -Name $mod)) {
        Write-Host "Instalando modulo $mod ..." -ForegroundColor Yellow
        Install-Module $mod -Scope CurrentUser -Force -AllowClobber
    }
}

Import-Module Microsoft.Graph.Authentication -ErrorAction Stop
Import-Module Microsoft.Graph.Mail -ErrorAction Stop

# Fix para EventSourceException en Windows PowerShell 5.1
try { [System.AppContext]::SetSwitch("System.Diagnostics.Tracing.EventSource.IsSupported", $false) } catch {}

# --- Conectar a Graph (abre browser para login) ---
Write-Host "Conectando a Microsoft Graph..." -ForegroundColor Cyan
$context = Get-MgContext
if (-not $context) {
    try {
        Connect-MgGraph -Scopes "Mail.Read" -NoWelcome -UseDeviceCode -ErrorAction Stop
    } catch {
        # EventSourceException en PS 5.1 - puede ser que la auth funciono igual
        $context = Get-MgContext
        if (-not $context) {
            Write-Host "ERROR: No se pudo conectar a Microsoft Graph." -ForegroundColor Red
            Write-Host "Corre el script desde tu PowerShell para re-autenticarte." -ForegroundColor Yellow
            exit 1
        }
    }
    $context = Get-MgContext
}
if (-not $context) {
    Write-Host "ERROR: No se pudo conectar a Microsoft Graph." -ForegroundColor Red
    exit 1
}
$userId = $context.Account
Write-Host "Conectado como: $userId" -ForegroundColor Green

# --- Patrones SR ---
$patternSR = '(?:SR\s*[-]?\s*)?4-(\d{10})'
$patternSolo = '(?<![\d-])\b(\d{10})\b(?![\d-])'

# --- Leer fecha desde ultimo.txt ---
$ultimoPath = "c:\code\oracle\ultimo.txt"
if (Test-Path $ultimoPath) {
    $fechaDesde = Get-Date (Get-Content $ultimoPath -First 1).Trim()
    Write-Host "Usando fecha desde ultimo.txt: $($fechaDesde.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow
} else {
    $fechaDesde = (Get-Date).AddDays(-1).Date
    Write-Host "No se encontro ultimo.txt, buscando desde ayer." -ForegroundColor Yellow
}
$fechaHasta = Get-Date

$resultados = @{}
$carpetasBuscadas = @()

$fechaISO = $fechaDesde.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

Write-Host "========================================" -ForegroundColor Green
Write-Host " Buscador de SRs en Outlook (Graph API)" -ForegroundColor Green
Write-Host " Rango: $($fechaDesde.ToString('dd-MMM-yyyy HH:mm')) a $(Get-Date -Format 'dd-MMM-yyyy HH:mm')" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# --- Funcion para buscar en una carpeta de Graph ---
function Buscar-EnCarpetaGraph {
    param(
        [string]$carpetaId,
        [string]$carpetaNombre,
        [int]$nivel = 0
    )

    $indent = "  " * $nivel
    Write-Host "${indent}Buscando en: $carpetaNombre ..." -ForegroundColor Cyan

    try {
        $filter = "receivedDateTime ge $fechaISO"
        $params = @{
            UserId = $script:userId
            MailFolderId = $carpetaId
            Filter = $filter
            Select = @("subject","receivedDateTime","body")
            Top = 100
            OrderBy = @("receivedDateTime desc")
        }

        $resultado = Get-MgUserMailFolderMessage @params -All -ErrorAction Stop
        $mensajes = @($resultado)

        if ($mensajes.Count -gt 0) {
            Write-Host "${indent}  -> $($mensajes.Count) correos en rango de fechas" -ForegroundColor Gray
            $script:carpetasBuscadas += "$carpetaNombre ($($mensajes.Count) correos)"

            foreach ($mail in $mensajes) {
                try {
                    $fecha = $mail.ReceivedDateTime.ToLocalTime()
                    if ($fecha -lt $fechaDesde) { continue }

                    $asunto = $mail.Subject
                    $cuerpo = $mail.Body.Content
                    if ($mail.Body.ContentType -eq "html") {
                        $cuerpo = $cuerpo -replace '<[^>]+>', ' '
                        try { $cuerpo = [System.Web.HttpUtility]::HtmlDecode($cuerpo) } catch {}
                    }
                    $textoCompleto = "$asunto $cuerpo"

                    $srsEncontrados = @{}

                    $matchesSR = [regex]::Matches($textoCompleto, $patternSR, 'IgnoreCase')
                    foreach ($m in $matchesSR) {
                        $numero = $m.Groups[1].Value
                        $srsEncontrados["SR 4-$numero"] = $true
                    }

                    $matchesSolo = [regex]::Matches($textoCompleto, $patternSolo)
                    foreach ($m in $matchesSolo) {
                        $numero = $m.Groups[1].Value
                        $srsEncontrados["SR 4-$numero"] = $true
                    }

                    foreach ($srCompleto in $srsEncontrados.Keys) {
                        if (-not $script:resultados.ContainsKey($srCompleto) -or $fecha -lt $script:resultados[$srCompleto].FechaObj) {
                            $script:resultados[$srCompleto] = [PSCustomObject]@{
                                SR       = $srCompleto
                                Fecha    = $fecha.ToString("yyyy-MM-dd HH:mm")
                                FechaObj = $fecha
                                Asunto   = $asunto
                                Carpeta  = $carpetaNombre
                            }
                        }
                    }
                } catch {}
            }
        }
    } catch {
        Write-Host "${indent}  -> Error: $_" -ForegroundColor Yellow
    }

    # Buscar subcarpetas
    try {
        $subCarpetas = Get-MgUserMailFolderChildFolder -UserId $userId -MailFolderId $carpetaId -ErrorAction Stop
        foreach ($sub in $subCarpetas) {
            Buscar-EnCarpetaGraph -carpetaId $sub.Id -carpetaNombre $sub.DisplayName -nivel ($nivel + 1)
        }
    } catch {}
}

# --- Obtener todas las carpetas de correo ---
Write-Host "Obteniendo carpetas de correo..." -ForegroundColor Cyan
try {
    $carpetas = Get-MgUserMailFolder -UserId $userId -Top 100 -ErrorAction Stop
} catch {
    Write-Host "ERROR obteniendo carpetas: $_" -ForegroundColor Red
    exit 1
}

foreach ($carpeta in $carpetas) {
    Buscar-EnCarpetaGraph -carpetaId $carpeta.Id -carpetaNombre $carpeta.DisplayName -nivel 0
}

# --- RESULTADOS ---
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

$csvPath = "c:\code\oracle\resultados_sr_outlook.csv"
$oldPath = "c:\code\oracle\old.csv"

if (Test-Path $csvPath) {
    Copy-Item -Path $csvPath -Destination $oldPath -Force
    Write-Host "CSV anterior guardado como old.csv" -ForegroundColor Yellow
}

if ($resultados.Count -eq 0) {
    Write-Host "No se encontraron SRs en el rango de fechas." -ForegroundColor Red
} else {
    $srsTodos = @{}
    $todosSrPath2 = "c:\code\oracle\todos_sr.csv"
    if (Test-Path $todosSrPath2) {
        Import-Csv $todosSrPath2 | ForEach-Object { $srsTodos[$_.SR] = $true }
    }

    $listaResultados = $resultados.Values | Sort-Object SR | ForEach-Object {
        $esNuevo = -not $srsTodos.ContainsKey($_.SR)
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
        Write-Host "SRs NUEVOS (no estaban en todos_sr.csv): $($nuevos.Count)" -ForegroundColor Green
    }
    Write-Host ""

    $listaResultados | Format-Table -AutoSize -Wrap

    $listaResultados | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
    Write-Host "Resultados exportados a: $csvPath" -ForegroundColor Green

    Write-Host ""
    Write-Host "--- LISTADO DE SRs ---" -ForegroundColor Cyan
    foreach ($r in $listaResultados) {
        $tag = if ($r.New -eq "true") { " ** NUEVO **" } else { "" }
        $color = if ($r.New -eq "true") { "Green" } else { "White" }
        Write-Host "  $($r.SR)$tag" -ForegroundColor $color
    }
}

# Actualizar todos_sr.csv (lista acumulada historica)
$todosSrPath = "c:\code\oracle\todos_sr.csv"
$srsExistentes = @{}
if (Test-Path $todosSrPath) {
    Import-Csv $todosSrPath | ForEach-Object { $srsExistentes[$_.SR] = $_ }
}
if ($resultados.Count -gt 0) {
    $nuevosAgregados = 0
    foreach ($r in $resultados.Values) {
        if (-not $srsExistentes.ContainsKey($r.SR)) {
            $srsExistentes[$r.SR] = [PSCustomObject]@{
                SR         = $r.SR
                PrimeraVez = $r.Fecha.Substring(0,10)
                Asunto     = $r.Asunto
            }
            $nuevosAgregados++
        }
    }
    $srsExistentes.Values | Sort-Object SR | Export-Csv -Path $todosSrPath -NoTypeInformation -Encoding UTF8
    if ($nuevosAgregados -gt 0) {
        Write-Host "$nuevosAgregados SR(s) agregado(s) a todos_sr.csv (total: $($srsExistentes.Count))" -ForegroundColor Cyan
    }
}

# Guardar timestamp en ultimo.txt
$fechaHasta.ToString("yyyy-MM-dd HH:mm:ss") | Out-File -FilePath $ultimoPath -Encoding UTF8 -Force
Write-Host ""
Write-Host "Fecha guardada en ultimo.txt: $($fechaHasta.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Green
Write-Host "Listo." -ForegroundColor Green
