@echo off
set "BASH_PATH=P:\\VMS\\infra-tools-getstart\\virtual-machine"
set "BASH_PATH=%BASH_PATH:\=/%"

::CURRENT_DIR
::PREFIJO_VM
::ENVIRONMENT
::FIRST_TIME
::USERNAME

echo %BASH_PATH%
"C:\Program Files\Git\bin\bash.exe" -c "'%BASH_PATH%'/common/common.sh %BASH_PATH% 'paul-laptop01' 'w001' 'false' 'paul'
