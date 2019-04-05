#!/bin/sh
path='/home/compiler/NEETPrep/NEETprepBackend/'
path_to_run='~/NEETPrep/Scripts/run_app.sh'
if [ "$(id -u)" == "0" ]; then
   echo "This script must not be run as root" 1>&2
   exit 1
fi
cd $path

build () {
    echo 'Building on '
    echo `pwd`
    docker build -t registry.gitlab.com/learner.in/learnerwebapi:dev .
}

compose () {
    echo 'Compose up'
    docker-compose up
}

signup () {
    docker login registry.gitlab.com
}

if [ "$1" = "run" ]; then
    compose
fi

if [ "$1" = "build" ]; then
    echo 'Starting build'
    build
fi

if [ "$1" = "signin" ]; then
    signup
fi
