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
    exit 0
}

compose () {
    echo 'Compose up'
    docker-compose up
}

compose_down () {
    docker-compose down
}

signup () {
    docker login registry.gitlab.com
    exit 0
}

reset () {
    echo "Are you sure you want to reset docker volumes? (y,N)?"
    read choice
    if [[ $choice == 'Y' || $choice == 'y' || $choice == 'yes' ]]; then   
        echo "Deleting docker volumes, please wait..."
        compose_down
        sleep 2
        docker rmi $(docker images -q) 
        if [ "$?" != 0 ]; then 
            echo "Failed at docker rmi"
            return
        fi
        
        echo "Pruning System"
        sleep 2
        sudo docker system prune 
        if [ "$?" != 0 ]; then 
            echo "Failed at docker system prune"
            return
        fi
        
        cd node_modules/
        docker volume rm neetprepbackend_node_modules
        if [ "$?" != 0 ]; then 
            echo "Failed at docker volume rm neetprepbackend_node_modules"
            return
        fi
        
        docker volume rm neetprepbackend_bower_components
        if [ "$?" != 0 ]; then 
            echo "Failed at docker volume rm neetprepbackend_bower_components"
            return
        fi
        cd ..
        
        echo "Removing tmpdb"
        sleep 2
        sudo rm -rfv tmpdbs
        
        echo "Done"
        echo "Would you like to rebuild? (y,N)"
        read build_choice
        if [[ $build_choice == 'Y' || $build_choice == 'y' || $build_choice == 'yes' ]]; then
            build
        else
            exit 0;
        fi
    fi
    
    exit 0;
}

if [ "$1" = "run" ]; then
    compose
    
elif [ "$1" = "stop" ]; then
    compose_down

elif [ "$1" = "build" ]; then
    echo 'Starting build'
    build

elif [ "$1" = "signin" ]; then
    signup

elif [ "$1" = "reset" ]; then
    reset

else
    echo "usage: $0 [option]"
    echo "These are the command line options you can use"
    echo "  build       To build the project using docker config in the project dir"
    echo "  signin      To signin to gitlab servers"
    echo "  run         To run the project in the local environment"
    echo "  reset       To clean docker volumes"
    echo "  help        To Show this message"
fi
