#!/bin/sh
path='/home/chronix/NEETPrep/NEETprepBackend/'
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
echo 'Running docker exec'
cd $path
echo `pwd`
docker exec -it neetprep_node /bin/bash
echo 'Loading data'
yarn run data:load
echo 'Loading schema'
yarn run generate:schema
echo 'db sync'
yarn run db:sync
echo 'starting'
yarn start
