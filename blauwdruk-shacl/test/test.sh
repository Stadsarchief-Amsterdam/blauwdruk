#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

echo ARCHIEFBLOK
echo == Validate archiefblok-correct1.ttl:
shacl validate -s ../archiefblok.ttl -d archiefblok/archiefblok-correct1.ttl
echo == Validate archiefblok-incorrect1.ttl:
shacl validate -s ../archiefblok.ttl -d archiefblok/archiefblok-incorrect1.ttl

echo GROEP
echo == Validate groep-correct1.ttl:
shacl validate -s ../groep.ttl -d groep/groep-correct1.ttl
echo == Validate groep-incorrect1.ttl
shacl validate -s ../groep.ttl -d groep/groep-incorrect1.ttl

echo BESTANDDEEL
echo == Validate bestanddeel-correct1.ttl
shacl validate -s ../bestanddeel.ttl -d bestanddeel/bestanddeel-correct1.ttl
echo == Validate bestanddeel-incorrect1.ttl
shacl validate -s ../bestanddeel.ttl -d bestanddeel/bestanddeel-incorrect1.ttl

echo AKTE
echo == Validate akte-correct1.ttl
shacl validate -s ../akte.ttl -d akte/akte-correct1.ttl
echo == Validate akte-incorrect1.ttl
shacl validate -s ../akte.ttl -d akte/akte-incorrect1.ttl
echo == Validate akte-minimal1.ttl
shacl validate -s ../akte.ttl -d akte/akte-minimal1.ttl
