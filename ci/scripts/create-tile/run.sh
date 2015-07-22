echo $PWD

TASK_ROOT_DIR=$PWD

apt-get install zip

export RELEASE_NAME=${release_name:-appdirect-dev}
export RELEASE_VERSION=${release_version:-1.5}
export RELEASE_FILE=${RELEASE_NAME}-${RELEASE_VERSION}.tgz

export TILE_VERSION=${tile_version:-1.5}
export TILE_RELEASE_NAME=p-${RELEASE_NAME}
export TILE_RELEASE_VERSION=${TILE_RELEASE_NAME}-${TILE_VERSION}

echo Creating a pivnet tile
mkdir -p /tmp/tile-results/metadata /tmp/tile-results/releases

cp $TASK_ROOT_DIR/release/$RELEASE_FILE /tmp/tile-results/releases
#cp $TASK_ROOT_DIR/repo/tile-config/metadata/*yml /tmp/tile-results/metadata
cp $TASK_ROOT_DIR/repo/*ile-v${TILE_VERSION}.yml /tmp/tile-results/metadata

cd /tmp/tile-results

zip -r ${TILE_RELEASE_VERSION}.pivotal metadata releases

mv ${TILE_RELEASE_VERSION}.pivotal $TASK_ROOT_DIR

ls -al $TASK_ROOT_DIR
