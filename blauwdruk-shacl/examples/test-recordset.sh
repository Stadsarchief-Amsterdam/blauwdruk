#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

echo ARCHIEFBLOK
echo == Validate archiefblok-correct1.ttl:
shacl validate -s ../recordset.ttl -d recordset/archiefblok-correct1.ttl
echo == Validate archiefblok-incorrect1.ttl:
shacl validate -s ../recordset.ttl -d recordset/archiefblok-incorrect1.ttl

echo GROEP
echo == Validate groep-correct1.ttl:
shacl validate -s ../recordset.ttl -d recordset/groep-correct1.ttl
echo == Validate groep-incorrect1.ttl
shacl validate -s ../recordset.ttl -d recordset/groep-incorrect1.ttl

echo BESTANDDEEL
echo == Validate bestanddeel-correct1.ttl
shacl validate -s ../recordset.ttl -d recordset/bestanddeel-correct1.ttl
echo == Validate bestanddeel-incorrect1.ttl
shacl validate -s ../recordset.ttl -d recordset/bestanddeel-incorrect1.ttl

