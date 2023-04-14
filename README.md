# packer_tidepool
 packer + ubuntu + tidepool development environment 

## Usage:

packer build -only=virtualbox-iso.vm -var-file=os_pkrvars/ubuntu/ubuntu-22.10-x86_64.pkrvars.hcl  ./packer_templates

### Requires: 

- (Ubuntu)[https://ubuntu.com/download/server] 
- (Packer)[https://developer.hashicorp.com/packer/downloads] 
- (Tidepool)[https://github.com/tidepool-org/development]

### Background: 

- (Tutorial)[https://betterprogramming.pub/create-a-self-contained-and-portable-kubernetes-cluster-with-k3s-and-packer-16aa43899e2f] 
- (Samples repo)[https://github.com/brandonleegit/PackerBuilds]
