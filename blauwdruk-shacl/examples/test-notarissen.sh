#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

echo NOTARISSEN
echo == Validate finding aid notarissen
shacl validate -s ../recordset.ttl -d recordset/saa5075.ttl
echo == Validate notarial deed
shacl validate -s ../record.ttl -d record/saa5075-akte476255.ttl
echo == Validate notarial deed - person observation
shacl validate -s ../agent.ttl -d agent/saa5075-akte476255-person1.ttl


