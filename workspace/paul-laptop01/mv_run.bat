@echo off

rem Verificar si se pasaron los argumentos requeridos
if "%1"=="" (
    echo Debes proporcionar el argumento HOST_MAIN
    exit /b 1
)
if "%2"=="" (
    echo Debes proporcionar el argumento ENVIRONMENT
    exit /b 1
)
if "%3"=="" (
    echo Debes proporcionar el argumento ACTION
    exit /b 1
)

rem HOST_MAIN
rem BASE_EXECUTION_PATH_VM
rem VMS_CONFIG_PATH
rem WORKSPACE

rem Capturar los argumentos pasados
set "HOST_MAIN=%1"
set "ENVIRONMENT=%2"
set "ACTION=%3"
set "HOST_VM=%4"
set "WORKSPACE=%5"

set "BASE_EXECUTION=P:\\VMS\\infra-tools-getstart"

set "BASE_EXECUTION_PATH_VM=%BASE_EXECUTION%\\virtual-machine"
set "BASE_EXECUTION_PATH_VM=%BASE_EXECUTION_PATH_VM:\=/%"

set "VMS_CONFIG_PATH=%BASE_EXECUTION%\\workspace\\%HOST_MAIN%\\vms.json"
set "VMS_CONFIG_PATH=%VMS_CONFIG_PATH:\=/%"

echo %HOST_MAIN%
echo %BASE_EXECUTION_PATH_VM%
echo %VMS_CONFIG_PATH%
echo %HOST_VM%
echo %WORKSPACE%

"C:\Program Files\Git\bin\bash.exe" -c "'%BASE_EXECUTION_PATH_VM%'/lib/common.sh %BASE_EXECUTION_PATH_VM% %VMS_CONFIG_PATH% %ENVIRONMENT% %ACTION%"

if not "%WORKSPACE%"=="" (
    set "HOST=%HOST_MAIN%-%ENVIRONMENT%"
    "C:\Program Files\Git\bin\bash.exe" -c "'%BASE_EXECUTION%'/workspace/up_workspace.sh %HOST_VM% %WORKSPACE%"
)
