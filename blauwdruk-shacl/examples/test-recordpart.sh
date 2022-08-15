#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

echo DIGITAAL INFORMATIEOBJECTONDERDEEL
echo == Validate dioo-correct1.ttl
shacl validate -s ../recordpart.ttl -d recordpart/dioo-correct1.ttl
