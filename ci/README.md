# AppDirect Tile CI

The scripts provided here use [Concourse](http://concourse.ci/) for CI.
Concourse can be running on a simple local vm or on some remote system.
Install and configure [fly](http://concourse.ci/fly-cli.html) utility to execute the task or pipeline.

There are two tasks defined - create tile and create release.
Check the separate readmes for executing the task or pipeline on Concourse.

Update the config/default.yml file with the correct s3 bucket references, github repos etc.
Use a separate and private yaml file to store the AWS access tokens that wont get included into github or other systems.
