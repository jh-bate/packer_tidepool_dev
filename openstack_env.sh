#!/bin/sh -eu

export FLAVOR_ID=$(openstack flavor show -f value -c id c2-burst.c1r1)
export NETWORK_ID=$(openstack network show -f value -c id private-net)
export SECURITY_GROUP=$(openstack security group show -f value -c id default)
export CC_SECURITY_GROUP_ID=$( openstack security group show first-instance-sg -f value -c id )
export SOURCE_IMAGE_ID=$(openstack image show -f value -c id ubuntu-minimal-22.04-x86_64)
export DEST_IMAGE_NAME="tidepool_ubuntu_22.04"
export FLOATING_IP_NETWORK=$(openstack network show -f value -c id public-net)