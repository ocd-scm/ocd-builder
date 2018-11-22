#!/bin/bash

set -e

# Add the ocd-meta repo to helm
helm repo list | grep ocd-meta > /dev/null
if [ "$?" != "0" ]; then
    echo adding repo ocd-meta 
    helm repo add ocd-meta https://ocd-scm.github.io/ocd-meta/charts
fi

# make sure we have the ocd-builder-credentials to tag the resultant image
helm upgrade --install \
    --set server=192.168.99.100:8443,user=developer,password=developer \
    ocd-builder-credentials \
    ocd-meta/ocd-builder-credentials

# install the builder which will build the code with the s2i image
helm upgrade --install \
     --set insecureSkipTlsVerify=true \
     -f realworld-builder.yaml \
     realworld \
     ../../ocd-builder/ocd-builder-1.0.1.tgz
     #ocd-meta/ocd-builder

# s2i imagees are maintained seperately so that we can security patch them independently of the code we build
oc import-image nodejs-8-rhel7:1-31 --from='registry.access.redhat.com/rhscl/nodejs-8-rhel7:1-31' --confirm
PROJECT=$(oc project --short)
oc tag $PROJECT/nodejs-8-rhel7:1-31 $PROJECT/nodejs-8-rhel7:latest
