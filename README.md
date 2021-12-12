# On demand GitHub runners using Hetzner Cloud

This repo allows you to use Hetzner Cloud to run GitHub action runners on demand.  
Terraform is used to create and destroy the runner, and I've also included examples  
of how to create a server snapshot in Hetzner Cloud using Ansible and Packer.  
The actions runner is based on Ubuntu 20.04  

## Usage

An example workflow script:  

```yaml
name: hcloud test

on:
  
  workflow_dispatch:
jobs:
  start-runner:
    runs-on: ubuntu-latest
    outputs:
      instance-id: ${{ steps.runner.outputs.instance-id }}
    steps:
    - name: Checkout Terraform code
      uses: actions/checkout@v2
      with:
        repository: andycockers/hcloud-actions-runner
        token: ${{ secrets.GH_PAT }}
        path: hcloud-actions-runner

    - id: runner
      name: Start runner
      uses: andycockers/hcloud-actions-runner/start@v0.1.0
      with:
        hcloud_token: ${{ secrets.HCLOUD_TOKEN }}
        type: "type=github_hcloud_runner"
        server_type: cx11
        location: fsn1
        network_id: "823122"
        github-token: ${{ secrets.GH_PAT }}

  main:
   needs: start-runner
   runs-on: ${{ needs.start-runner.outputs.instance-id }}
   steps:
     - run: uname -a

  stop-runner:
    if: always()
    needs: [start-runner, main]
    runs-on: ubuntu-latest
    steps:
    - name: Checkout Terraform code
      uses: actions/checkout@v2
      with:
        repository: andycockers/hcloud-actions-runner
        token: ${{ secrets.GH_PAT }}
        path: hcloud-actions-runner
    - name: Stop runner
      uses: andycockers/hcloud-actions-runner/stop@v0.1.0
      with:
        instance-id: ${{ needs.start-runner.outputs.instance-id }}
        hcloud_token: ${{ secrets.HCLOUD_TOKEN }}
        type: "type=github_hcloud_runner"
        network_id: "823122"
```

## Required inputs

token/github-token = A GitHub PAT (Personal Access Token). This should be an Action secret.  
hcloud_token = A Hetzner Cloud API token. This should be an Action secret.  
type = The label keypair of the Hetzner snapshot, i.e. type=github_hcloud_runner 
server_type = The specification of server to launch  
location = The Hetzner Cloud datacentre  
network_id = The network to attach to  

## Running as a different user

The runner is configured to run as a non-root user, user "ubuntu" in folder /home/ubuntu/actions-runner  
To ovveride this, you will need to build a base image with a different user and different base folder.  
Then, add the following start inputs:  

runner-home = The folder where the runner is configured  
runner-user = The non-root user.