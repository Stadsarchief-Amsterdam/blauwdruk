# Leer Linked Data

## Datastructuur

### Les 1
Je mag in Linked Data alle properties gebruiken die je wilt. Als het nodig is door elkaar. We hebben tot nu toe gebruik gemaakt van property-verzamelingen rdf, rdfs en rico. Een veel toegepaste andere verzameling van properties is schema.org.

Zo'n verzameling van properties heeft een bepaalde samenhang. In rico is het bijvoorbeeld logisch dat een knoop van het type rico:RecordSet de property rico:hasRecordSetType mag hebben. Dit soort samenhang wordt vastgelegd in een _ontologie_. Van elke property is bijvoorbeeld vastgelegd wat de _domain_ is, en de _range_. De domain van de property rico:hasRecordSetType is rico:RecordSet en de object van een triple met deze property is van het type rico:RecordSetType, met andere woorden: de range van rico:hasRecordSetType is rico:RecordSetType.

Lees de rico-ontologie in in GraphDB:
"Import" -> "RDF" -> "Get RDF data from a URL"

Gebruik deze URL en kies bij het inlezen voor 'named graph'.
https://www.ica.org/standards/RiC/RiC-O_v0-2.rdf 

Geef de graaf de naam "https://www.ica.org/standards/RiC/ontology".

Als je nu een graaf gaat visualiseren, zie je rdfs:labels die zijn gedefinieerd in de ontologie bij de relaties staan.

### Les 2
Een ontologie definieert nog meer samenhang. Zo leg je in de ontologie vast dat bepaalde types op elkaar lijken. Een rico:Family is namelijk een soort rico:Group, net als rico:Organization. En een rico:Group is een soort rico:Agent, net als rico:Person. Dit wordt klasse-hierarchie genoemd. Properties die gedefinieerd zijn bij rico:Agent zijn daardoor ook te gebruiken bij rico:Group en rico:Family. Een andere belangrijke klasse hierarchie in RiC-O is dat rico:Record, rico:RecordSet en rico:RecordPart alledrie subklasses zijn van rico:RecordResource.

Je kunt zelf ook classes definieren.

<https://id.archief.amsterdam/blauwdruk/Archief>
	a rdfs:Class ;
	owl:equivalentClass rico:RecordSet .

Dat is handig als je zelf aanvullende eigenschappen wilt definieren die nodig zijn om specifieke dingen vast te leggen over een Archief bij het Stadsarchief Amsterdam. De class 'Archief' kan dus alle properties gebruiken die bij rico:RecordSet zijn gedefnieerd en ook alle properties die je zelf definieert. In dit voorbeeld zijn deze niet opgenomen, maar we kunnen een eigen definitie van Archief goed gebruiken om de data te kunnen controleren. Dat leren we in de volgende les.

### Les 3
De vrijheid die Linked Data biedt is niet altijd handig. Soms moet je gewoon zeker weten dat er een plaats in het depot is vastgelegd bijvoorbeeld. En dat ook kunnen controleren. Daarvoor gebruiken we SHACL. Omdat we in Amsterdam graag andere randvoorwaarden (_constraints_) willen kunnen controleren voor Archief en Bestanddeel is het nodig om deze apart te definieren en te bepalen dat ze hetzelfde zijn als een rico:RecordSet.

Bij een Archief vinden we in Amsterdam een archiefvormer verplicht, bij een Bestanddeel niet. Dus:

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl:           <http://www.w3.org/2002/07/owl#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .

blauwdruk:Archief a sh:NodeShape, rdfs:Class ;
    sh:targetClass blauwdruk:Archief ;
    owl:equivalentClass rico:RecordSet ;
    sh:property [
        sh:path rico:hasAccumulator ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
    ] .

blauwdruk:Bestanddeel a sh:NodeShape, rdfs:Class ;
    sh:targetClass blauwdruk:Bestanddeel ;
    owl:equivalentClass rico:RecordSet ;
    sh:property [
        sh:path rico:hasAccumulator ;
        sh:maxCount 1 ;
    ] .

```

Lees deze graaf in met als naam: http://rdf4j.org/schema/rdf4j#SHACLShapeGraph. Deze graaf van Shapes is niet meer terug te zien in de lijst van geimporteerde grafen maar door het deze naam te geven weet GraphDB dat ze de shapes in de graaf moet gebruiken om te valideren bij het importeren.

### Les 4
Als het goed is gaat het nu mis als je onderstaande data wilt invoeren
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .

<https://id.archief.amsterdam/8> 
	rdf:type blauwdruk:Archief ;
	rico:hasRecordSetType ric-rst:Fonds .
```

Vraag: Waaarom?

maar dit mag wel:
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .

<https://id.archief.amsterdam/9> 
	rdf:type blauwdruk:Bestanddeel ;
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

### Les 5
Doe opnieuw:

```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType $rst ;
     		rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
     FILTER (?begindate < '1600'^^xsd:gYear)
}

```

