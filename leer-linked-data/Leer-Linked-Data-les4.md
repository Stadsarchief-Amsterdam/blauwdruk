# Leer Linked Data

## Datastructuur in SHACL

### Les 1
De vrijheid die Linked Data biedt is niet altijd handig. Soms moet je gewoon zeker weten dat er een plaats in het depot is vastgelegd bijvoorbeeld. En dat ook kunnen controleren. Daarvoor gebruiken we SHACL. Omdat we in Amsterdam graag andere randvoorwaarden (_constraints_) willen kunnen controleren voor Archiefblok en Bestanddeel is het nodig om deze apart te definieren en te bepalen dat ze een soort rico:RecordSet zijn (zie rdfs:subClassOf).

Bij een Archief vinden we in Amsterdam een archiefvormer verplicht, bij een Bestanddeel niet. Dus:

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .

blauwdruk:Fonds a sh:NodeShape, rdfs:Class ;
    sh:targetClass blauwdruk:Fonds ;
    rdfs:label "Archiefblok" ;
    rdfs:subClassOf rico:RecordSet ;
    sh:property [
        sh:path rico:hasAccumulator ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
    ] .

blauwdruk:File a sh:NodeShape, rdfs:Class ;
    sh:targetClass blauwdruk:File ;
    rdfs:label "Bestanddeel" ;    
    rdfs:subClassOf rico:RecordSet ;
    sh:property [
        sh:path rico:hasAccumulator ;
        sh:maxCount 1 ;
    ] .

```

Lees deze graaf in met als naam: http://rdf4j.org/schema/rdf4j#SHACLShapeGraph. Deze graaf van Shapes is niet meer terug te zien in de lijst van geimporteerde grafen maar door het deze naam te geven weet GraphDB dat ze de shapes in de graaf moet gebruiken om te valideren bij het importeren.

### Les 2
Als het goed is gaat het nu mis als je onderstaande data wilt invoeren
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .

<https://id.archief.amsterdam/8> 
	rdf:type blauwdruk:Fonds ;
	rico:hasRecordSetType ric-rst:Fonds .
```

Vraag: Waarom?

maar dit mag wel:
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .

<https://id.archief.amsterdam/9> 
	rdf:type blauwdruk:File ;
	rico:hasRecordSetType ric-rst:File ;
    rico:isAssociatedWithDate [
        a rico:DateRange ;
        rico:expressedDate "1423 - 1424" ;
        rico:hasBeginningDate [
            a rico:SingleDate ;
            rico:normalizedDateValue "1423"^^xsd:gYear
        ] ;
        rico:hasEndDate [
            a rico:SingleDate ;
            rico:normalizedDateValue "1424"^^xsd:gYear
        ]
    ] .

```

### Les 3
Class-typering.

### Les 4
Data-typering.

### Les 5 
Brug naar les 5: de datastructuren kunnen de basis vormen voor een formulier.

