# Data for testing the Blauwdruk SHACL definitions

This directory contains files that can be used to test the SHACL files in this blauwdruk-shacl directory. It contains files that should not give error messages (with 'correct' in the filename) and files that should give error messages intentionally (with 'incorrect' in the filename). Sometimes it contains 'minimal' and 'maximal' files as well; these are correct but contain the minimal or maximum data that should give a correct SHACL-validation.

IMPORTANT NOTE: The examples do not imply decisions on the way URI's of the Amsterdam City Archives are or should be created! Neither about the usage of blanknodes in the data.

# SHACL validation
I've used Jena to validate data against shacl shapes. After installation you can use the Command Line Interface (CLI) command 'shacl'.

## Install Jena
[Jena](https://jena.apache.org/) is "a free and open source Java framework for building Semantic Web and Linked Data applications". You can download it [here](https://jena.apache.org/download/), unpack the tar or zip and place it on a convenient place on your system.

## Adding paths to JENA
You need to add the paths to the JENA-directory for your system to find the CLI-tools, as described [here](https://jena.apache.org/documentation/tools/).

e.g.
```
export JENA_HOME=/usr/bin/apache-jena/apache-jena-3.14.0
export PATH=$PATH:$JENA_HOME/bin
```

## Use CLI command 'shacl'
Jena contains the CLI command 'shacl' to validate data. It is described in more detail [here](https://jena.apache.org/documentation/shacl/).

e.g. 
```
$ shacl validate -s ../01-archiefblok.ttl -d 01-archiefblok/archiefblok-correct1.ttl
```

The shell-script test.sh runs tests on the available test files.
