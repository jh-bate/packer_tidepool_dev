# packer_tidepool
 packer + ubuntu + tidepool development environment 

## Usage:

```
packer build -on-error=ask -only=virtualbox-iso.vm -var-file=os_pkrvars/ubuntu/ubuntu-22.04-x86_64.pkrvars.hcl  ./packer_templates
```

### Notes:

- The process will appear to hang at `Waiting for SSH to become available..` but things are being processed in the background and you  can either just wait or if you are courious you can view the virtualbox instance that is being created and see the changes being applied in the terminal there 
- The whole process takes a while, it was around 20 mins on my machine `Build 'virtualbox-iso.vm' finished after 19 minutes 46 seconds.`

### Requires: 
 
- (Packer)[https://developer.hashicorp.com/packer/downloads] 
- (Tidepool)[https://github.com/tidepool-org/development]
- (Bento)[https://github.com/chef/bento]
- (Ubuntu)[https://ubuntu.com]

### Background: 

- (Tutorial)[https://betterprogramming.pub/create-a-self-contained-and-portable-kubernetes-cluster-with-k3s-and-packer-16aa43899e2f] 
- (Samples repo)[https://github.com/brandonleegit/PackerBuilds]
