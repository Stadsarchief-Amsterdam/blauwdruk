#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

echo PERSOON
echo == Validate persoon-correct1.ttl
shacl validate -s ../agent.ttl -d agent/persoon-correct1.ttl
echo == Validate persoon-incorrect1.ttl
shacl validate -s ../agent.ttl -d agent/persoon-incorrect1.ttl
