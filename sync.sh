#!/bin/bash

mkdir -p /tmp/rom # Where to sync source
git clone https://github.com/akhilnarang/scripts
cd scripts
bash setup/android_build_env.sh
cd /tmp/rom

# Repo init command, that -device,-mips,-darwin,-notdefault part will save you more time and storage to sync, add more according to your rom and choice. Optimization is welcomed! Let's make it quit, and with depth=1 so that no unnecessary things
repo init -q --no-repo-verify --depth=1 -u  https://github.com/Spark-Rom/manifest -b fire  -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/flashokiller/mainfest_personal --depth 1 .repo/local_manifests
# Sync source with -q, no need unnecessary messages, you can remove -q if want! try with -j30 first, if fails, it will try again with -j8
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j 30 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j 8