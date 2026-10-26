$origen  = "G:\Mi unidad\Material Iglesia"
$destino = "C:\Users\Acer\quartz\content"

robocopy $origen $destino /MIR /XD ".obsidian" ".git" ".trash" "x Borradores x" /XF "index.md" ".gitkeep"

if ($LASTEXITCODE -ge 8) {
    Write-Host "Error al copiar las notas" -ForegroundColor Red
    exit 1
}

# Corregir el frontmatter inválido en las copias
$utf8 = New-Object System.Text.UTF8Encoding($false)
Get-ChildItem $destino -Recurse -Filter *.md | ForEach-Object {
    $texto = [System.IO.File]::ReadAllText($_.FullName, $utf8)
    $nuevo = $texto -replace '(?m)^Tono:[ \t]*-[ \t]*$', 'Tono: "-"'
    if ($nuevo -ne $texto) {
        [System.IO.File]::WriteAllText($_.FullName, $nuevo, $utf8)
    }
}

Set-Location "C:\Users\Acer\quartz"
npx quartz sync --no-pull
