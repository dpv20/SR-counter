# pull.ps1 - Sincronizar (traer) los CSVs/ultimo.txt mas recientes desde Git
# Correr ANTES de buscar_sr_graph.ps1 / buscar_sr_outlook.ps1 cuando se usa en varios PCs.

$basePath = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

if (-not (Test-Path (Join-Path $basePath ".git"))) {
    Write-Host "ERROR: esta carpeta no es un repo git." -ForegroundColor Red
    exit 1
}

Write-Host "Sincronizando con Git (pull)..." -ForegroundColor Cyan
Push-Location $basePath
try {
    git pull --rebase --autostash 2>&1 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Pull completado." -ForegroundColor Green
    } else {
        Write-Host "Aviso: git pull termino con codigo $LASTEXITCODE." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Aviso: git pull fallo: $_" -ForegroundColor Yellow
} finally {
    Pop-Location
}
