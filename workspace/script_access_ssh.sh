#!/bin/bash
ssh-keygen

USER_T="paul"
HOST_APP="192.168.18.122"
HOST_INFRA="192.168.18.123"
HOST_DEPLOY="192.168.18.124"

ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_APP}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_INFRA}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_DEPLOY}

USER_T="paul"
HOST_APP="192.168.18.141"
HOST_INFRA="192.168.18.142"
HOST_DEPLOY="192.168.18.143"

ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${WORKSPACE}_${APP_HOST}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${WORKSPACE}_${INFRA_HOST}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${WORKSPACE}_${DEPLOY_HOST}

ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${WORKSPACE}_${APP_HOST}
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${WORKSPACE}_${INFRA_HOST}
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${WORKSPACE}_${DEPLOY_HOST}



#PAUL-LAPTOP windows
setx WORKSPACE SANDBOX
setx APP_HOST 192.168.202.124
setx INFRA_HOST 192.168.202.125
setx DEPLOY_HOST 192.168.202.126
