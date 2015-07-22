# Download the latest Linux 64 bit CF CLI binary from https://github.com/cloudfoundry/cli/releases
# Edit the link as newer releases are published

# Remove older references to cf_cli
./removeBlob.sh cf-linux-amd64.tgz 
CF_CLI_VERSION=${cf_cli_version:-6.9.0}
wget "https://cli.run.pivotal.io/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github-rel" -O cf-linux-amd64.tgz
echo no | ./addBlob.sh cf-linux-amd64.tgz cf_cli
