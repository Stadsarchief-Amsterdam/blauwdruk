#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

echo NOTARISSEN
echo == Validate finding aid
shacl validate -s ../recordset.ttl -d recordset/saa5075.ttl
echo == Validate finding aid
shacl validate -s ../recordset.ttl -d recordset/saa5075.ttl


