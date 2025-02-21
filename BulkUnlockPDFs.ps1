# Requires Qpdf installed, and install path replaced below if not added to PATH.
$hardcodedQpdfPath = "C:\Program Files\qpdf 11.10.1\bin\qpdf.exe"

# Replace path with Folder that contains all password-protected PDFs, and below enter the Password.
$pdfFolder = "C:\Users\nikosp\Documents\PasswordPDFsFolder"
$password = "yourpassword"

# Create "Unlocked" directory if it doesn't exist
$unlockedFolder = "$pdfFolder\Unlocked"
if (!(Test-Path -Path $unlockedFolder)) {
    New-Item -ItemType Directory -Path $unlockedFolder | Out-Null
}

# Check if qpdf is available in system PATH
$qpdfPath = Get-Command qpdf -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue
if (-not $qpdfPath) {
    $qpdfPath = $hardcodedQpdfPath
}

# Check if qpdf exists before proceeding
if (!(Test-Path -Path $qpdfPath)) {
    Write-Host "Error: qpdf not found in PATH or at $hardcodedQpdfPath"
    exit 1
}

# Process PDFs
Get-ChildItem -Path $pdfFolder -Filter "*.pdf" | ForEach-Object {
    $inputFile = $_.FullName
    $outputFile = "$unlockedFolder\$($_.Name)"
    Start-Process -NoNewWindow -FilePath $qpdfPath -ArgumentList "--password=$password --decrypt `"$inputFile`" `"$outputFile`"" -Wait
}
