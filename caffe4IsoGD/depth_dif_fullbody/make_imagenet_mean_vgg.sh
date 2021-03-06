#!/usr/bin/env sh
# Compute the mean image from the imagenet training leveldb
# N.B. this is available in data/ilsvrc12
CAFFERoot=/home/huogen/git/caffe #change to your caffe folder
EXAMPLE=../depth_dif_fullbody
TOOLS=$CAFFERoot/build/tools
DATA=../depth_dif_fullbody
$TOOLS/compute_image_mean $EXAMPLE/DepthDIf_fullbody_train_lmdb_vgg $DATA/DepthFullbody_dif_mean_vgg.binaryproto

echo "Done."
