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

# Test files
The repo contains in the example folder correct LOD resources, as well as intentionally incorrect ones. 

