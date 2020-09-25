#!/bin/bash

project=$1

if [ ! $project ]
then
    echo "missing project name argument"
    exit 1
fi

# compiles the project in release mode
docker run --rm --volume "$(pwd)/:/src" --workdir "/src/" swift-lambda-builder swift build --product $project -c release

# packages the compiled project into a zip
docker run --rm --volume "$(pwd)/:/src" --workdir "/src/" swift-lambda-builder scripts/package-helper.sh $project
