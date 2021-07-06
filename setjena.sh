#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

echo is JENA_HOME set correctly?
echo $JENA_HOME

echo is JENA_HOME added to the path?
echo $PATH

echo Does shacl work?
shacl --version
