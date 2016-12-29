#!/bin/bash

checkdocker
check4dockerimage "${APP_IMG_NAME}/${APP_IMG_TAG}" BUILD

if [ "$BUILD" == "Y" ]; then
    rm -rf $BUILD_TMP
    mkdir -p $BUILD_TMP
    cd $BUILD_TMP

    dockerprox "DOCKER_LINE"

    # Since BUILD is now "Y" The vers file actually makes the dockerfile
    . ${APP_PKG_LOC}/${APP_VERS_FILE}

    sudo docker build -t $APP_IMG .
    sudo docker push $APP_IMG

    cd $MYDIR
    rm -rf $BUILD_TMP
    echo ""
    @go.log INFO "$APP_NAME package build with $APP_VERS_FILE"
    echo ""
else
    @go.log WARN "Not rebuilding $APP_NAME"
fi


