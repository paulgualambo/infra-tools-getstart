#!/bin/bash
CURRENT_DIR='/home/paul/Documents/projects/infra-tools-getstart/virtual-machine'

ENVIRONMENT="SANDBOX"
USER_T="paul"

#first time
$CURRENT_DIR/vagrant-process.sh $CURRENT_DIR $ENVIRONMENT 'up' $USER_T 'false'
$CURRENT_DIR/vagrant-process.sh $CURRENT_DIR $ENVIRONMENT 'halt' $USER_T 'false'
$CURRENT_DIR/vagrant-process.sh $CURRENT_DIR $ENVIRONMENT 'up' $USER_T 'true'

#second time always
#$CURRENT_DIR/vagrant-process.sh $CURRENT_DIR $ENVIRONMENT 'up' 'paul' 'true'