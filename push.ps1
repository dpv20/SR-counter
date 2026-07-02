# push.ps1 - Subir a Git los CSVs/ultimo.txt actualizados
# Correr DESPUES de buscar_sr_graph.ps1 / buscar_sr_outlook.ps1 cuando se usa en varios PCs.

$basePath = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

if (-not (Test-Path (Join-Path $basePath ".git"))) {
    Write-Host "ERROR: esta carpeta no es un repo git." -ForegroundColor Red
    exit 1
}

Write-Host "Subiendo cambios a Git (push)..." -ForegroundColor Cyan
Push-Location $basePath
try {
    git add resultados_sr_outlook.csv old.csv todos_sr.csv ultimo.txt 2>&1 | Out-Null
    $hayCambios = git status --porcelain -- resultados_sr_outlook.csv old.csv todos_sr.csv ultimo.txt
    if ($hayCambios) {
        git commit -m "Actualizar SRs $(Get-Date -Format 'yyyy-MM-dd HH:mm')" 2>&1 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
        git push 2>&1 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Cambios subidos a Git." -ForegroundColor Green
        } else {
            Write-Host "Aviso: git push termino con codigo $LASTEXITCODE." -ForegroundColor Yellow
        }
    } else {
        Write-Host "No hay cambios para subir." -ForegroundColor Gray
    }
} catch {
    Write-Host "Aviso: git push fallo: $_" -ForegroundColor Yellow
} finally {
    Pop-Location
}
