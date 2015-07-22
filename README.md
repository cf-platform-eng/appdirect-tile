# AppDirect Tile Repo

This is a repo to generate an App Direct Service Broker Tile that can be imported into Pivotal Cloud Foundry Ops Mgr.
The Tile would allow users to register a pre-provisioned AppDirect SAAS Service Broker with PCF and expose the set of services available on it in the Cloud Foundry Marketplace. The Tile essentially is comprised of two bosh jobs - one to register the appdirect service broker with PCF and the other to delete the broker.

# Tile Generation

* Ensure bosh gems and cli are installed in order to create a Bosh release.
* Run fetch_cf_cli.sh script to fetch CF CLI binary and add it as a blob to the release.
  To upgrade the CF cli, edit/update the download link specified inside the fetch_cf_cli.sh script.
* Create a release file using createRelease.sh script.
* Create a new image (only if necessary) for the tile by first creating an image and converting it to [Base-64 encoding](http://www.base64-image.de/step-2.php) and use that in the image tag inside the tile file. Ensure the sizes are 128x128 pixel size for it to fit inside the tile image on the Ops Mgr.
* Edit the stemcell references based on running on vSphere or AWS inside the tile file.
```
  name: bosh-vsphere-esxi-ubuntu-trusty-go_agent                           # UNCOMMENT for vSphere
  file: bosh-stemcell-2865.1-vsphere-esxi-ubuntu-trusty-go_agent.tgz       # UNCOMMENT for vSphere
  #name: light-bosh-aws-xen-hvm-ubuntu-trusty-go_agent                     # UNCOMMENT for AWS
  #file: light-bosh-stemcell-2865.1-aws-xen-hvm-ubuntu-trusty-go_agent.tgz # UNCOMMENT for AWS
```
* Run createTile.sh to generate the AppsDirect Service Broker Tile (.pivotal file).

## Tile Import into Ops Mgr
`Important: Backup the Ops Mgr configuration before proceeding to next step.`
* Change the name of the Tile and versions as necessary. 
 Note: The version bundled in this repo is for Ops Manager 1.3 and would be automatically upgraded to 1.4 if getting imported into PCF 1.4
* Import the Tile into non-Production version of Ops Mgr.
* Provide the three attributes required to register the AppDirect Marketplace
  * AppDirect Service Broker URL
  * AppDirect Access ID or username
  * AppDirect Secret Token or password
* Apply the changes
* Verify the Tile works before proceeding with to use it in Production
* Note: It would require a login into Ops Mgr to remove the associated metadata and releases before re-importing the same version of Tile and release in Ops Mgr. 

# Tile Removal
* Delete from Ops Mgr
* Wait for Ops mgr to complete the removal
* Login into Ops Mgr machine via ssh
* Switch to root
* Go to the /var/tempest/releases folder
* Delete the previous release bits. This only deletes from the Ops mgr. BOSH might still be carrying a reference to the previous release bits.
* Best to regenerate the release with newer/higher version and rebuild the tile if plannig on iterative development. 
  Change the version number specified in createRelease.sh
* Go to the /var/tempest/workspace/default/metadata
* Check for the associated appdirect tile metadata file (the name would be randomly generated during the earlier import). 
  Delete the tile manfiest metadata file.

