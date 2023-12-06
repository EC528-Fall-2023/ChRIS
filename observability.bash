#!/usr/bin/bash

SCRIPT_DIR="$(pwd)"
app_name=''
namespace=''

while getopts ":a:n:h:" flag
do
    case "${flag}" in
	a) app_name=${OPTARG};;
	n) namespace=${OPTARG};;
	h)
	    echo "Usage $0 [-a app_name (optional)] [-n namespace (mandatory)]"
	    exit 1
	    ;;
    esac
done

if [$namespace -eq '']; then
    echo "namespace is not set"
    exit 1
fi

echo "Checking for necessary yaml files"
if [-f $SCRIPT_DIR/grafana.yaml]; then
    echo "Missing grafana.yaml file"
    exit
fi
if [-f $SCRIPT_DIR/otel_py_instrumentation.yaml.yaml]; then
    echo "Missing otel_py_instrumentation.yaml.yaml file"
    exit
fi
if [-f $SCRIPT_DIR/otel_py_collector.yaml]; then
    echo "Missing otel_py_collector.yaml file"
    exit
fi
echo "done"

echo "Installing Grafana"
echo "Please add an email for receiving Grafana notifications"
read email
echo "You entered $email"
echo "Please add email password for the prior email"
read pw
echo "You entered $pw"
python -c 'import yaml;f=open("values.yaml");y=yaml.safe_load(f);y["grafana.ini"]["smtp"]["user"] = $email;y["grafana.ini"]["smtp"]["password"] = $pw;print(yaml.dump(y, default_flow_style=False, sort_keys=False))'
helm install grafana$app_name grafana/grafana -f grafana.yaml
echo "done"

echo "Install Tempo"
helm repo add grafana https://grafana.github.io/helm-charts
helm install my-release$app_name grafana/tempo
echo "done"

echo "Install Open Telemetry"
oc apply -f otel_py_instrumentation.yaml
oc apply -f otel_py_collector.yaml
echo "done"
echo "To connect Open Telemetry Autoinstrumentation, remember to launch an annotated application using 'oc apply (application)'"

echo "Installing Loki parser"
git clone https://github.com/jakubzolkos/loki-parser
cd loki-parser/loki-parser
echo "Enter loki gateway service host name"
read lokiHost
echo "You entered: $lokiHost"
echo "Enter loki gateway HTTP port"
read lokiPort
echo "You entered: $lokiPort"
echo "Enter redis service host name"
read redisHost
echo "You entered: $redisHost"
echo "Enter redis service HTTP port"
read redisPort
echo "You entered: $redisPort"

python -c 'import yaml;f=open("values.yaml");y=yaml.safe_load(f);y["logParser"]["namespace"] = $namespace;y["logParser"]["lokiHost"] = $lokiHost;y["logParser"]["lokiPort"] = $lokiPort;y["logParser"]["redisHost"] = $redisHost;y["logParser"]["redisPort"] = $redisPort; print(yaml.dump(y, default_flow_style=False, sort_keys=False))'
helm install --values values.yaml loki-parser .
cd $SCRIPT_DIR
echo "done"

