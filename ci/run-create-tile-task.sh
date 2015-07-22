# Use -p to run in privileged/root mode to install wget via apt-get

# Ensure the product_version contains a 3rd level of sub-version

release_name=appdirect                   \
release_version=1.5                      \
tile_version=1.5                         \
fly execute -p                           \
      -c scripts/create-tile/task.yml    \
      -i repo=..                         \
      -i release=../release
