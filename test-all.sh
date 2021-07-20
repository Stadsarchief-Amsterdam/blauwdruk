#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

#shacl validate -s saa-rico-shapes.ttl -d afbeelding/correct/afbeelding-correct1.ttl
#shacl validate -s saa-rico-shapes.ttl -d archief/incorrect/archief-incorrect1.ttl
#shacl validate -s saa-rico-shapes.ttl -d informatieobject/correct/informatieobject-correct1.ttl
#shacl validate -s saa-rico-shapes.ttl -d informatieobject/correct/informatieobject-minimal1.ttl
#shacl validate -s saa-rico-shapes.ttl -d informatieobject/incorrect/informatieobject-incorrect1.ttl

# shacl validate -s saa-rico-shapes.ttl -d aa-voorbeelden/1386/1386.rdf.xml
shacl validate -s saa-rico-shapes.ttl -d aa-voorbeelden/394/394.rdf.xml
