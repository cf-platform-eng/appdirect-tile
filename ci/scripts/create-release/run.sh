echo $PWD

echo "Env variables passed in:"
env
echo ""

echo "Now setting custom variables"
export RELEASE_NAME=${release_name:-appdirect-dev}
export RELEASE_VERSION=${release_version:-1.5}
export RELEASE_FILE=${RELEASE_NAME}_${RELEASE_VERSION}.tgz

# Need for downloading and bundling CF cli binary as blob
export CF_CLI_VERSION=${cf_cli_version:-6.9.0}

echo "Env variables used :"
env
echo ""

#apt-get update
apt-get install wget

ls repo/

echo Creating a bosh release
cd repo
./fetch_cf_cli.sh
bosh -n create release --name $RELEASE_NAME --version $RELEASE_VERSION --force --with-tarball
#ls -al ./dev_releases/appdirect-dev/appdirect-(.+).tgz
