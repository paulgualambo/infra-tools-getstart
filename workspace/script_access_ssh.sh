#!/bin/bash

USER_T="paul"
HOST_APP="192.168.18.122"
HOST_INFRA="192.168.18.123"
HOST_DEPLOY="192.168.18.124"

ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_APP}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_INFRA}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_DEPLOY}

USER_T="paul"
HOST_APP="192.168.18.141"
HOST_INFRA="192.168.18.142"
HOST_DEPLOY="192.168.18.143"

ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_APP}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_INFRA}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_DEPLOY}