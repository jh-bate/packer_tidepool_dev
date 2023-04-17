# packer_tidepool
 packer + ubuntu + tidepool development environment 

## Usage:

- [install packer](https://developer.hashicorp.com/packer/downloads)
- [install virtualbox](https://www.virtualbox.org/wiki/Downloads)

run the process below 

```
packer build -on-error=ask -only=virtualbox-iso.vm -var-file=os_pkrvars/ubuntu/ubuntu-22.04-x86_64.pkrvars.hcl  ./packer_templates
```


### Tidepool platform specific scripts:

 - [1_dependancies](./packer_templates/scripts/_tidepool/1_dependancies.sh)
 - [2_docker](./packer_templates/scripts/_tidepool/2_docker.sh)
 - [3_K8s](./packer_templates/scripts/_tidepool/3_k8s.sh)
 - [4_mongo](./packer_templates/scripts/_tidepool/4_mongo.sh)
 - [5_tidepool_dev](./packer_templates/scripts/_tidepool/5_tidepool_dev.sh)

### Notes:

- The process will appear to hang at `Waiting for SSH to become available..` but things are being processed in the background and you  can either just wait or if you are courious you can view the virtualbox instance that is being created and see the changes being applied in the terminal there 
- The whole process takes a while, it was around 20 mins on my machine `Build 'virtualbox-iso.vm' finished after 19 minutes 46 seconds.`

### Requires: 
 
- [Packer](https://developer.hashicorp.com/packer/downloads)
- [Tidepool](https://github.com/tidepool-org/development)
- [Bento](https://github.com/chef/bento)
- [Ubuntu](https://ubuntu.com)

### Background: 

- [Tutorial](https://betterprogramming.pub/create-a-self-contained-and-portable-kubernetes-cluster-with-k3s-and-packer-16aa43899e2f)
- [Samples repo](https://github.com/brandonleegit/PackerBuilds)
