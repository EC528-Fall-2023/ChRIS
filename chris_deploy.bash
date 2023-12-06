#!/usr/bin/bash
input=''
if oc whoami &> /dev/null; then
    echo "User logged in"
else
    echo "User not logged in. Aborting"
    exit
fi
echo "Enter a deployment name:"
read release_name
if [ "$input" = '' ]; then
    release_name="chris1"
else
    release_name="chris-$input"
fi

pfcon_deploy="$release_name-pfcon"
helm repo add fnndsc https://fnndsc.github.io/charts
helm repo update
echo "Deploy ChRIS with OTEL instrumentation? (y/n): "
read instrument
if [ "$instrument" = "y" ]; then
    echo "Deploying ChRIS with annotation"
    helm upgrade --install --values chris_annotated.yaml $release_name fnndsc/chris
    oc annotate deployment -l app.kubernetes.io/name=pfcon instrumentation.opentelemetry.io/inject-python='true'
    oc annotate pod -l app.kubernetes.io/name=pfcon instrumentation.opentelemetry.io/inject-python='true'
    oc rollout restart deployment/$pfcon_deploy
elif [ "$instrument" = "n" ]; then
    echo "Deploying ChRIS without annotation"
    helm upgrade --install --values chris_base.yaml $release_name fnndsc/chris
else
    echo "Invalid response. Aborting"
    exit
fi

# #---------------------Testing Block--------------------------------
# # for testing confirmation
# oc get pods
# # for testing - instant deletion
# helm uninstall $release_name
# #-------------------------------------------------------------------------