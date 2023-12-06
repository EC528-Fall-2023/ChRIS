#!/usr/bin/bash
if oc whoami &> /dev/null; then
    echo "User logged in"
else
    echo "User not logged in. Aborting"
    exit
fi
echo "Enter a deployment name:"
read release_name
pfcon_deploy="$release_name-pfcon"
helm repo add fnndsc https://fnndsc.github.io/charts
helm repo update
helm upgrade --install --values chris.yaml $release_name fnndsc/chris

oc annotate deployment -l app.kubernetes.io/name=pfcon instrumentation.opentelemetry.io/inject-python='true'
#wait 10 seconds for a pod to be deployed
#sleep 10
oc annotate pod -l app.kubernetes.io/name=pfcon instrumentation.opentelemetry.io/inject-python='true'
oc rollout restart deployment/$pfcon_deploy

# #---------------------Testing Block--------------------------------
# # for testing confirmation
# oc get pods
# # for testing - instant deletion
# helm uninstall $release_name
# #-------------------------------------------------------------------------