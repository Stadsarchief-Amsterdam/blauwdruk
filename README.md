# Blauwdruk

"Blue print" of the datamodel of the [City Archives Amsterdam](https://archief.amsterdam/). Contains a [SHACL](https://www.w3.org/TR/shacl/) file for validating its data to [Records in Contexts Ontology](https://www.ica.org/standards/RiC/ontology).

Obviously, under construction.

# SHACL validation
We use Jena to validate data against shacl shapes. After installation we use the CLI command 'shacl'.

eg. 
```
$ shacl validate -s saa-rico-shapes.ttl -d 05-informatieobject/incorrect/informatieobject-incorrect1.ttl
```

# Test files

## Individual, fake test-records per saa-ont Entity
For every (numbered) entity in the 'blauwdruk' we create (mostly fake) examples to test the shacl-files.

## Complete finding aids
For testing purposes we created some complete finding aids, based on Encoded Archival Description.

