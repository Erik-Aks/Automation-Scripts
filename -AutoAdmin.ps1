# Definiowanie ścieżek
$backupSource = "C:\Users\Public\Documents"
$backupDestination = "D:\Backup\Documents_$(Get-Date -Format 'yyyyMMdd_HHmm')"

# Tworzenie kopii zapasowej
Write-Output "Tworzenie kopii zapasowej..."
New-Item -ItemType Directory -Path $backupDestination -Force
Copy-Item -Path "$backupSource\*" -Destination $backupDestination -Recurse -Force
Write-Output "Kopia zapasowa zakończona: $backupDestination"

# Czyszczenie folderu tymczasowego
$tempFolder = "C:\Windows\Temp"
Write-Output "Czyszczenie folderu tymczasowego: $tempFolder"
Remove-Item -Path "$tempFolder\*" -Force -Recurse -ErrorAction SilentlyContinue
Write-Output "Folder tymczasowy wyczyszczony."

# Monitorowanie użycia procesora
$cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
Write-Output "Aktualne użycie CPU: $cpuUsage%"

# Zapis logów do pliku
$logFile = "D:\Backup\admin_log.txt"
$logMessage = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | CPU Usage: $cpuUsage% | Backup: $backupDestination"
Add-Content -Path $logFile -Value $logMessage
Write-Output "Log zapisany do $logFile"
