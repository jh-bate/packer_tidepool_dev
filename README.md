# packer_tidepool
 packer + ubuntu + tidepool development environment 

## Usage:

```
packer build -on-error=ask -only=virtualbox-iso.vm -var-file=os_pkrvars/ubuntu/ubuntu-22.04-x86_64.pkrvars.hcl  ./packer_templates
```

### Uses: 
 
- (Packer)[https://developer.hashicorp.com/packer/downloads] 
- (Tidepool)[https://github.com/tidepool-org/development]
- (Bento)[https://github.com/chef/bento]
- (Ubuntu)[https://ubuntu.com]

### Background: 

- (Tutorial)[https://betterprogramming.pub/create-a-self-contained-and-portable-kubernetes-cluster-with-k3s-and-packer-16aa43899e2f] 
- (Samples repo)[https://github.com/brandonleegit/PackerBuilds]
