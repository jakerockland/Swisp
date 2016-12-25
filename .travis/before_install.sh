#!/bin/bash

TOOLCHAIN_VERSION=swift-DEVELOPMENT-SNAPSHOT-2016-12-15-a

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

    # Install Swift for OS X

    curl -O https://swift.org/builds/development/xcode/${TOOLCHAIN_VERSION}/${TOOLCHAIN_VERSION}-osx.pkg

    sudo installer -pkg ${TOOLCHAIN_VERSION}-osx.pkg -target /

else

    # Install Swift for Linux

    sudo apt-get install clang libicu-dev

    wget https://swift.org/builds/development/ubuntu1404/${TOOLCHAIN_VERSION}/${TOOLCHAIN_VERSION}-ubuntu14.04.tar.gz

    wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -

    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

    gpg --verify ${TOOLCHAIN_VERSION}-ubuntu14.04.tar.gz.sig

    tar xzf ${TOOLCHAIN_VERSION}-ubuntu14.04.tar.gz

    export PATH=${PWD}/${TOOLCHAIN_VERSION}-ubuntu14.04/usr/bin:"${PATH}"

fi
