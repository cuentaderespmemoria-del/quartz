$origen  = "G:\Mi unidad\Material Iglesia"
$destino = "C:\Users\Acer\quartz\content"

robocopy $origen $destino /MIR /XD ".obsidian" ".git" ".trash" "x Borradores x" /XF "index.md" ".gitkeep"

if ($LASTEXITCODE -ge 8) {
    Write-Host "Error al copiar las notas" -ForegroundColor Red
    exit 1
}

Set-Location "C:\Users\Acer\quartz"
npx quartz sync --no-pull
