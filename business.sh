#! /bin/bash

source env_variables
. kube_functions

$(aws ecr get-login --no-include-email --region eu-west-2)
echo "Building ${BL_image} from ${BL_repo}"
docker build -t ${BL_image}:${namespace} ${BL_repo}
docker tag takeon-dev-bl:${namespace} 014669633018.dkr.ecr.eu-west-2.amazonaws.com/takeon-dev-bl:${namespace}
docker push 014669633018.dkr.ecr.eu-west-2.amazonaws.com/takeon-dev-bl:${namespace}

# Delete previous pod
kubectl delete pods -l app=business-layer -n ${namespace} 