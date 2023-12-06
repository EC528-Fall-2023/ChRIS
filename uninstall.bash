#!/usr/bin/bash

SCRIPT_DIR="$(pwd)"
app_name=''

while getopts ":a:h:" flag
do
    case "${flag}" in
	a) app_name=${OPTARG};;
	h)
	    echo "Usage $0 [-a app_name (mandatory)]"
	    exit 1
	    ;;
    esac
done

if [ $app_name == '' ]
then
    echo "appname is not set"
    exit 1
fi

helm uninstall grafana$app_name
helm uninstall tempostack
helm uninstall loki$app_name
helm uninstall loki-parser$app_name
