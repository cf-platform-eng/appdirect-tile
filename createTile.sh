#!/bin/sh

function realpath() {
      [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

SCRIPT=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT)
ROOT_DIR=$SCRIPT_DIR

if [ "$#" -lt 1 ]; then

  echo "Usage: <output-directory>"
  echo " 1st arg: output directory to generate the tile metadata and pivotal tile"
  echo ""
  exit -1
fi

OUTPUT_DIR=$(realpath $1)
RELEASE_DIR=$SCRIPT_DIR
TEMPLATES_DIR=$ROOT_DIR/tile-templates

# Source the product properties

RELEASE_VERSION=1.7
PRODUCT_VERSION=1.7
PRODUCT_NAME=appdirect-broker-experimental
RELEASE_NAME=appdirect-broker

$SCRIPT_DIR/createRelease.sh $RELEASE_DIR

TILE_FILE_FULL_PATH=`ls $TEMPLATES_DIR/*tile.yml`
RELEASE_TARFILE=`ls $RELEASE_DIR/*releases/*/*.tgz`
TILE_FILE_NAME=`basename $TILE_FILE_FULL_PATH`

rm -rf $OUTPUT_DIR/tmp
mkdir -p $OUTPUT_DIR/tmp
pushd $OUTPUT_DIR/tmp

mkdir -p metadata releases  migrations/v1
migrations_timestamp=`date +"%Y%m%d%H%M"`

cp $TEMPLATES_DIR/*migration.js migrations/v1/${migrations_timestamp}_migration.js
cp $TILE_FILE_FULL_PATH metadata/$TILE_FILE_NAME
cp $RELEASE_TARFILE releases/

zip -r ${PRODUCT_NAME}-v${PRODUCT_VERSION}.pivotal metadata releases migrations
mv ${PRODUCT_NAME}-v${PRODUCT_VERSION}.pivotal ..
popd
echo "Created Tile:  $OUTPUT_DIR/${PRODUCT_NAME}-v${PRODUCT_VERSION}.pivotal "
echo ""
