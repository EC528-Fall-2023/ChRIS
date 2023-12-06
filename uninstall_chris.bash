release_name=''

echo "Enter the ChRIS deployment name:"
read release_name

if [ "$release_name" = '' ]; then
    helm uninstall chris1
else
    helm uninstall chris1-$release_name
fi
