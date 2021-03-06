#!/bin/bash

#
# *******************************************************************************
#   Copyright (c) 2019 Symplectic. All rights reserved.
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at http://mozilla.org/MPL/2.0/.
# *******************************************************************************
#   Version :  ${git.branch}:${git.commit.id}
# *******************************************************************************
#

HOME_PATH=$(dirname "$0")
#echo ${HOME_PATH}

if [ ! -d ${HOME_PATH}/../scripts ];
then
    cp ${HOME_PATH}/../examples/example-config/* ${HOME_PATH}/../
    cp ${HOME_PATH}/../examples/example-bin/*.sh ${HOME_PATH}/../
    echo "Config initialised."
    mkdir ${HOME_PATH}/../scripts
    cp -r ${HOME_PATH}/../examples/example-scripts/example-elements ${HOME_PATH}/../scripts
    echo "Scripts initialised."
else
    echo "This Harvester already seems to be initialised."
fi