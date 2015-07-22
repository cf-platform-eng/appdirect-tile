# Run Pipeline on Concourse

## Run the Pipeline using real/remote resources on Concourse CI

* To check the status of the run, access the Concourse page (if running a local instance on Vagrant, the address is http://192.168.100.4:8080) and click on the Folders/drawers icon on the right hand top left corner and click on one-off tasks recently kicked off.
Or Check the accordion on the left and click the related pipeline and click to see the stages.


Run the tasks first to test against local resources before running pipeline. Pipeline would use real github checked in resources, s3 etc.

Edit the config/default.yml and use another file (like ~/private.yml) to store the secret credentials so it does not get checked into git. Use additional files to specify versions of tile, cf_cli, release etc that can go as a set for each new release or Ops mgr version.

Sample config in private.yml can set values for AWS access keys
```
release-access-key: ...
release-secret-key: ...
```

## Running the Pipeline

Execute the fly command line specifying the Pipeline and configuration overrides that would provide the various values for AWS s3 bucket credentials, repo name/location, CF credentials etc. The following command registers the pipeline against Concourse with the name wildcard_plugin. The pipeline can be triggered via  a change submission to Github repo or manually by going to the Concourse WebUI and clicking  on the Plus symbol against the Tasks.

```
# Execute this from the <Repository>/ci folder so the repo is the parent folder of current working directory.
fly configure -c scripts/pipeline.yml \
       --vars-from config/default.yml \
       --vars-from config/v1.5.yml \
       --vars-from ~/private.yml      \
       appdirect-pipeline
```

#Note:
In order to multiple roundtrips making changes and fixing errors/paths/variables each time against remote git while testing the pipeline, use a local running git daemon.  That way all changes get commmited against th local git server without pushing commits to remote git.
Use following alias to set up the local git daemon:
```
git config --global alias.serve "daemon --verbose --export-all --base-path=.git --reuseaddr --strict-paths .git/"
```

Then run:
```
git serve
```
This should allow a local git daemon. Push changes. Temporarily swap the github repo to point to the local github daemon inside the <repo>/ci/config/default.yml file to serve from local github.
Once things are working fine, stop the daemon, restore back the github url inside ci/config/default.yml and commmit changes to remote github.

