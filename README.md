# Blauwdruk

This repo contains the "Blue print" of the datamodel of the [City Archives Amsterdam](https://archief.amsterdam/). It contains a file with [SHACL](https://www.w3.org/TR/shacl/) shapes to validate its data to [Records in Contexts Ontology](https://www.ica.org/standards/RiC/ontology).

Obviously, under construction.

# SHACL validation
We use Jena to validate data against shacl shapes. After installation we use the Command Line Interface (CLI) command 'shacl'.

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
$ shacl validate -s saa-sh.ttl -d 01-archief/correct/archief-correct1.ttl
```

The shell-script test.sh runs tests on the available test files.

# Ontology, shapes and vocabulary
We needed some derived subclasses of RiC-O entities. This enables us to introduce shapes for different requirements of these different subclasses. The subclasses are defined in saa-ont.ttl.

For every Class defined in saa-ont we develop shapes in SHACL, stored in saa-sh.ttl. This helps to define formally all the requirements we have for the various parts in the archival description.

We introduce extra DocumentaryFormTypes in saa-voc.ttl.

# Test files
The repo contains correct LOD resources, as well as intentionally incorrect ones. 

## Individual, fake test-records per saa-ont Entity
For every (numbered) entity in the 'blauwdruk' we create (mostly fake) examples to test the shacl-shapes. The incorrect examples should give error messages if validated against the shapes defined in saa-sh.ttl.

## Complete finding aids
For testing purposes we created some complete finding aids, based on Encoded Archival Description.

