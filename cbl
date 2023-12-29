#!/bin/bash

CLOUDBEAT_PATH="./cloudbeat/"

build() {
    (cd $CLOUDBEAT_PATH && GOOS=darwin GOARCH=arm64 go build -v)
}

run() {
    LOGGER=""
    if [ -z "$1" ]; then
        LOGGER="-d $1"
    fi
    
    (cd $CLOUDBEAT_PATH \
        && ./cloudbeat -e -v $LOGGER 2>&1 > /dev/null \
        | jq  '[."log.level", ."log.logger", ."@timestamp", ."message"] | join(" |  "), ""' -M -r)
    
}

configure() {
    file="cbl-resources/cloudbeat.$1.yml"
        
    if ! [ -f $file ]; then
        echo "Unknown configuration for $1"
        exit 1
    fi

    cp $file cloudbeat/cloudbeat.yml
}

clean() {
    (cd $CLOUDBEAT_PATH && git checkout cloudbeat.yml)
}

case $1 in

    'conf')
        # configures cloudbeat.yml
        configure $2
        ;;
    
    'build')
        # builds for darwin
        build
        ;;
    
    'run')
        # runs with pretty logs
        run $2
        ;;

    'br')
        # builds and then runs
        build 
        run $2
        ;;

    'clean')
        # Resets cloudbeat.yml
        clean
        ;; 

    *)
        echo "Unknown option $1"
        ;;

esac