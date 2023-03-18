#!/bin/sh
set -eu

if [ -z "$REMOTE_HOST" ]; then
    echo "Input REMOTE_HOST is required!"
    exit 1
fi

if [ -z "$DIRECTORY" ]; then
    echo "Input DIRECTORY is required!"
    exit 1
fi

echo "Add known hosts"
mkdir -p ~/.ssh
eval $(ssh-agent)
ssh-keyscan "$SSH_HOST" >> ~/.ssh/known_hosts
ssh-keyscan "$SSH_HOST" >> /etc/ssh/ssh_known_hosts

tar cjvf - -C "$GITHUB_WORKSPACE" "$DIRECTORY" | ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" 'tar -xjvf -'
echo "Upload finished"
if [ -n "$POST_UPLOAD_COMMAND" ];
    then
    echo "Upload post command specified, runnig. $POST_UPLOAD_COMMAND"
    ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" "eval $POST_UPLOAD_COMMAND"
fi
