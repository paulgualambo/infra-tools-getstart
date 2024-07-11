@echo off
set "BASE_EXECUTION_PATH=P:\\VMS\\infra-tools-getstart\\virtual-machine"
set "BASE_EXECUTION_PATH=%BASE_EXECUTION_PATH:\=/%"

set "VMS_CONFIG_PATH=P:\\VMS\\infra-tools-getstart\\workspace\\paul-laptop01\\vms.json"
set "VMS_CONFIG_PATH=%VMS_CONFIG_PATH:\=/%"

# BASE_EXECUTION_PATH
# VMS_CONFIG_PATH
set "ENVIRONMENT=study"
set "ACTION=up"

echo %BASE_EXECUTION_PATH%
echo %VMS_CONFIG_PATH%
"C:\Program Files\Git\bin\bash.exe" -c "'%BASE_EXECUTION_PATH%'/lib/common.sh %BASE_EXECUTION_PATH% %VMS_CONFIG_PATH% %ENVIRONMENT% %ACTION%
