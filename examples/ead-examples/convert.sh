#!/bin/bash

xsltproc ead2rico.xslt 1386/1386.ead.xml > 1386/1386.rdf.xml
rapper -o turtle 1386/1386.rdf.xml > 1386/1386.ttl

xsltproc ead2rico.xslt 394/394.ead.xml > 394/394.rdf.xml
rapper -o turtle 394/394.rdf.xml > 394/394.ttl