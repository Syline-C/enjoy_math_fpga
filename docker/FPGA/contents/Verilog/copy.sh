#!/bin/bash

whiskyPath="/home/fpga/Template/"

cp -r $whiskyPath/card ./
cp -r $whiskyPath/clean ./
cp -r $whiskyPath/init ./

if [ ! -d ./RTL ]; then cp -r $whiskyPath/RTL ./; fi
