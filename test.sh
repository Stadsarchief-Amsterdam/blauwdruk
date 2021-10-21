#!/bin/bash

export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin

shacl --version

shacl validate -s memorix-experiments/01-archief.ttl -d rico-examples/01-archief/incorrect/archief-incorrect1.ttl
shacl validate -s memorix-experiments/blauwdruk.ttl -d rico-examples/01-archief/incorrect/archief-incorrect1.ttl
# shacl validate -s saa-sh.ttl -d 01-archief/incorrect/archief-incorrect1.ttl
# shacl validate -s saa-sh.ttl -d 04-afbeelding/correct/afbeelding-correct2.ttl
# shacl validate -s saa-sh.ttl -d 05-informatieobject/correct/informatieobject-correct1.ttl
# shacl validate -s saa-sh.ttl -d 05-informatieobject/correct/informatieobject-minimal1.ttl
# shacl validate -s saa-sh.ttl -d 05-informatieobject/incorrect/informatieobject-incorrect1.ttl

# shacl validate -s saa-sh.ttl -d ead-examples/1386/1386.rdf.xml
# shacl validate -s saa-sh.ttl -d ead-examples/394/394.rdf.xml
# shacl validate -s saa-sh.ttl -d ead-examples/394/correct-fragment-394.ttl

# shacl validate -s person-example/Persoonsvermelding.ttl -d person-example/person.in.ttl
# shacl validate -s person-example/Persoonsvermelding.ttl -d person-example/person.out.ttl
# shacl validate -s blauwdruk.ttl -d 5e16843a-fe24-4fe9-9207-5cb57e586584.ttl

