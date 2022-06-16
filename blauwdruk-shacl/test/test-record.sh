#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

echo AKTE
echo == Validate akte-correct1.ttl
shacl validate -s ../record.ttl -d akte/akte-correct1.ttl
echo == Validate akte-incorrect1.ttl
shacl validate -s ../record.ttl -d akte/akte-incorrect1.ttl
echo == Validate akte-minimal1.ttl
shacl validate -s ../record.ttl -d akte/akte-minimal1.ttl

echo AFBEELDING
echo == Validate afbeelding-correct1.ttl
shacl validate -s ../record.ttl -d afbeelding/afbeelding-correct1.ttl
