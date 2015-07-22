# Use -p to run in privileged/root mode to install wget via apt-get

release_version=1.5                      \
release_name=appdirect                   \
cf_cli_version=6.9.0                     \
fly execute -p                           \
      -c scripts/create-release/task.yml \
      -i repo=..
