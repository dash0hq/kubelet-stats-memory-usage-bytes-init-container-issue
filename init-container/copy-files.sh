#!/bin/sh

set -eu

mkdir -p /another/directory
cp -R /init-container-files/ /another/directory

# for copying to the emptyDir volume, which was the first suspect.
# cp -R /init-container-files/ /empty-dir-mount-path
