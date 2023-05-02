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

mkdir -p ~/.ssh
eval $(ssh-agent)

tar cjvf - -C "$GITHUB_WORKSPACE" "$DIRECTORY" | ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" "cd $REMOTE_DESTINATION && tar -xjvf -"
echo "Upload finished"
if [ -n "$POST_UPLOAD_COMMAND" ];
    then
    echo "Upload post command specified, runnig. $POST_UPLOAD_COMMAND"
    ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" "eval $POST_UPLOAD_COMMAND"
fi
