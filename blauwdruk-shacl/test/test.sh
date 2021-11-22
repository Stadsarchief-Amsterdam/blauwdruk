#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

# shacl validate -s ../archiefblok.ttl -d archiefblok/archiefblok-correct1.ttl
# shacl validate -s ../archiefblok.ttl -d archiefblok/archiefblok-incorrect1.ttl

# shacl validate -s ../groep.ttl -d groep/groep-correct1.ttl
# shacl validate -s ../groep.ttl -d groep/groep-incorrect1.ttl

shacl validate -s ../bestanddeel.ttl -d bestanddeel/bestanddeel-correct1.ttl
shacl validate -s ../bestanddeel.ttl -d bestanddeel/bestanddeel-incorrect1.ttl

