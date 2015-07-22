# Run Tasks on Concourse

## Run the individual tasks using local resources

Note: Install fly or download it from concourse ui page and configure it against a running concourse instance before proceeding with next steps

* Running tasks using fly would use local resources as opposed to use real (git or s3) for pipeline.
* Run the create-release task first to create the bosh release
* To check the status of the run, access the Concourse page (if running a local instance on Vagrant, the address is http://192.168.100.4:8080) and click on the Folders/drawers icon on the right hand top left corner and click on one-off tasks recently kicked off.


## Running the create-release task

'create-release' task requires path to a local repository as input in form of repo variable

```
# Execute this from the <Repository>/ci folder so the repo is the parent folder of current working directory.
# Pass env variables to specify the release name, version and CF cli version
release_version=1.5  release_name=appdirect cf_cli_version=6.9.0  fly execute -c ./scripts/create-release/task.yml --i repo=../ --privileged
```

Save the tar ball (created inside the docker image if necessary) under <repo>/binaries folder either in s3 or locally from the build task

## Running the create-tile task

Run the 'create-tile' task once create-release task is successful 
* Ensure there is a tar ball containing the bosh release under the <repository>/release or some other path which needs to be specified as release input variable, along with path to the repository

```
# Execute this from the <Repository>/ci folder so the repo is the parent folder of current working directory.
# Pass env variables to specify the release name, version and any others (like tile or stemcell version)
release_version=1.5 release_name=appdirect tile_version=1.5  fly execute -p  -c scripts/create-tile/task.yml -i repo=..  -i release=../release

```
