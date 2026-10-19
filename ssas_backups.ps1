Import-Module SqlServer

$ServerName = 'SERVERNAME'
$BackupPath = 'PATH'
$Dt = Get-Date -Format "yyyyMMdd_HHmmss"

# Create backup folder if it doesn't exist
if (!(Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Force -Path $BackupPath | Out-Null
}

# Connect to SSAS
$Server = New-Object Microsoft.AnalysisServices.Server
$Server.Connect($ServerName)

try {

    foreach ($Database in $Server.Databases) {

        $DatabaseName = $Database.Name
        $BackupFile = Join-Path $BackupPath "${DatabaseName}_${Dt}.abf"

        Write-Host "Starting backup: $DatabaseName" -ForegroundColor Yellow

        Backup-ASDatabase `
            -Server $ServerName `
            -Name $DatabaseName `
            -BackupFile $BackupFile `
            -ApplyCompression `
            -AllowOverwrite `
            -ErrorAction Stop

        Write-Host "Backup successful: $BackupFile" -ForegroundColor Green
    }

}
catch {
    Write-Host "Backup failed: $($_.Exception.Message)" -ForegroundColor Red
}
finally {
    $Server.Disconnect()
}
