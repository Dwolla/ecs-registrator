@echo off

rem Allow the container to access the AWS credentials and metadata APIs. It is the batch equivalent of the script found at
rem https://docs.aws.amazon.com/AmazonECS/latest/developerguide/windows_task_IAM_roles.html.

setlocal enabledelayedexpansion

for /f "tokens=4" %%a in ('route.exe print 0.0.0.0 ^| findstr /r "0\.0\.0\.0.*[a-z]" ^| findstr /n /r "^" ^| findstr /r "^1:"') do (
  set GATEWAY=%%a
)
for /f "tokens=2" %%a in ('route.exe print 0.0.0.0 ^| findstr /r ".*Hyper-V Virtual Ethernet.*" ^| findstr /n /r "^" ^| findstr /r "^1:"') do (
  for /f "tokens=1 delims=..." %%b in ('echo %%a') do (
    set IFINDEX=%%b
  )
)
route.exe add 169.254.170.2 MASK 255.255.255.255 if %IFINDEX% %GATEWAY% > nul 2>&1
route.exe add 169.254.169.254 MASK 255.255.255.255 if %IFINDEX% %GATEWAY% > nul 2>&1

for /f "tokens=1" %%a in ('curl.exe -s http://169.254.169.254/latest/meta-data/local-ipv4') do ( call :trim LOCALIPV4 %%a )

set "NEWARGS=%*%"
set NEWARGS=%NEWARGS:{{ LocalIpV4 }}=!LOCALIPV4!% 

C:\Registrator\registrator.exe %NEWARGS%
goto :eof

:trim
  setlocal enabledelayedexpansion
  set args=%*
  for /f "tokens=1*" %%a in ("!args!") do endlocal & set %1=%%b
  exit /b