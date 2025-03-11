

# Ścieżka do pliku logów
$logFile = "C:\Logs\system_monitor.log"
if (!(Test-Path "C:\Logs")) { New-Item -ItemType Directory -Path "C:\Logs" }

# Pobieranie danych systemowych
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$cpuUsage = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
$ramUsage = Get-Counter '\Memory\Available MBytes' | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
$diskUsage = Get-PSDrive C | Select-Object Used, Free

# Formatowanie danych
$logEntry = @"
[$timestamp]
CPU Usage: $([math]::Round($cpuUsage, 2))%
Available RAM: $([math]::Round($ramUsage, 2)) MB
Disk Usage (C:): Used = $([math]::Round($diskUsage.Used / 1GB, 2)) GB, Free = $([math]::Round($diskUsage.Free / 1GB, 2)) GB

"@

# Zapis danych do loga
Add-Content -Path $logFile -Value $logEntry

# Wyświetlenie wyników w konsoli
Write-Output "System monitoring log updated: $logFile"
Write-Output $logEntry
