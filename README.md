# tailscale-ssh-deploy
deploy your git project without having to expose your server thanks to Tailscale SSH!


## Example

Here is an example of how to use the action

```yaml
- name: Setup Tailscale
  uses: tailscale/github-action@v2
  with:
    hostname: Github-actions
    oauth-client-id: ${{ secrets.TS_OAUTH_CLIENT_ID }}
    oauth-secret: ${{ secrets.TS_OAUTH_SECRET }}
    tags: tag:ci

- name: Start Deployment
  uses: FarisZR/tailscale-ssh-deploy@v1
  with:
    remote_host: root@100.107.201.124
    directory: generated
    remote_destination: /root/www
    post_upload_command: echo thats it
```

## Action Inputs
- `remote_host` Specify Remote host using their tailscale IPv4 address. The input value must be in this format (user@host). **required**
- `directory` Directory to upload **required**
- `remote_destination` The destination path on the remote host **required**
- `post_upload_command` A command to run on the remote host after the upload is finished **optional**
