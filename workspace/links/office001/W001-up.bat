@echo off
set "CURRENT_DIR=%CD%"
echo Directorio actual: %CURRENT_DIR%
set "BASH_PATH=%CURRENT_DIR:\=/%"

: "C:\Program Files\Git\bin\bash.exe" -c "'%BASH_PATH%'/../get-ips.sh"


"C:\Program Files\Git\bin\bash.exe" -c "'%BASH_PATH%'/../get-ips.sh 'office001'
"C:\Program Files\Git\bin\bash.exe" -c "'%BASH_PATH%'/../vagrant-process.sh 'office001' %BASH_PATH%/../../virtual-machine 'W001' 'up'"
"C:\Program Files\Git\bin\bash.exe" -c "'%BASH_PATH%'/../vagrant-process.sh 'office001' %BASH_PATH%/../../virtual-machine 'W001' 'reload --provision'"
"C:\Program Files\Git\bin\bash.exe" -c "'%BASH_PATH%'/../resume-vm.sh 'office001' %BASH_PATH%/../../virtual-machine 'W001' 'reload --provision'"