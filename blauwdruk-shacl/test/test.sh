#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

# shacl validate -s ../01-archiefblok.ttl -d 01-archiefblok/archiefblok-correct1.ttl
# shacl validate -s ../01-archiefblok.ttl -d 01-archiefblok/archiefblok-incorrect1.ttl

shacl validate -s ../02-groep.ttl -d 02-groep/groep-correct1.ttl
# shacl validate -s ../02-groep.ttl -d 02-groep/groep-incorrect1.ttl


