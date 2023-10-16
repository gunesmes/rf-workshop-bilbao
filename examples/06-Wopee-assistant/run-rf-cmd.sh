#!/bin/bash

gh release download --repo autonomous-testing/wopee.rf --pattern '*.whl'

pip3 install *.whl

# python3 -m robot --variable WOPEE_CONFIG:$1 --listener wopee_rf.listener tests/sample.robot
robot --variable WOPEE_CONFIG:$1 --listener wopee_rf.listener tests/sample.robot
