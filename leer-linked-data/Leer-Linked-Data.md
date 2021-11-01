# Leer Linked Data

## Voorbereiding
### GraphDB installeren
Zie: https://www.ontotext.com/products/graphdb/graphdb-free/

### Repo aanmaken in GraphDB
Setup -> Repositories -> Create New Repository

1. Geef de repo een naam
2. Vink aan: 'Supports SHACL validation'

## Data

### Les 1
Verbindingen in een netwerk (het wiskundige woord voor netwerk is 'graaf') leg je vast door aan te geven welke knoop met welke knoop is verbonden met welk relatie. Deze worden _triples_ genoemd. In Linked Data zijn alle knopen en relaties webadressen of beter Uniform Resource Identifiers (URI's). Je kunt je Linked Data dus opsommen door deze triples in URI's uit te drukken: ```<knoop1> <relatie> <knoop2> .```


```
<https://id.archief.amsterdam/1> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <https://www.ica.org/standards/RiC/ontology#RecordSet> .
<https://id.archief.amsterdam/1> <https://www.ica.org/standards/RiC/ontology#hasRecordSetType> <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Fonds> .
```

Het heeft dus altijd de structuur: ```<knoop1> <relatie> <knoop2> .``` Deze drie dingen van de triple heten respectievelijk: _subject_, _predicate_ (of _property_) en _object_.

Laad dit voorbeeld in GraphDB. Kies "Import" -> "RDF" -> "Import RDF Text Snippet" . Knip en plak bovenstaande voorbeeld daar in.

Discussie: De URI's voor RiC-O en RDF liggen vast, maar hoe moet de URI voor 'dingen' bij het Stadsarchief eruit zien?

### Les 2
De manier om triples uit te drukken zoals we in les 1.1 zagen wordt _n-triples_ genoemd. Overzichtelijker wordt het als je triples uitdrukt in _turtle_.


```
<https://id.archief.amsterdam/1> 
	<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <https://www.ica.org/standards/RiC/ontology#RecordSet> ;
	<https://www.ica.org/standards/RiC/ontology#hasRecordSetType> <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Fonds> .
```

Echt leesbaar voor mensen wordt het als je webadressen afkort met een _namespace_.

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .

<https://id.archief.amsterdam/1> 
	rdf:type rico:RecordSet ;
	rico:hasRecordSetType ric-rst:Fonds .
```

N-triples en Turtle drukken allebei dus op een andere manier dezelfde triples uit. Het zijn, in jargon, verschillende _serializaties_ van dezelfde RDF.

### Les 3

Laten we metadata van een ander archief aan de graaf toevoegen.
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .

<https://id.archief.amsterdam/2> 
	rdf:type rico:RecordSet ;
	rdfs:label "Archief van de Familie Boissevain en Aanverwante Families" ;
	rico:hasRecordSetType ric-rst:Fonds ;
    rico:hasAccumulator <https://id.archief.amsterdam/3> .

<https://id.archief.amsterdam/3>
	rdf:type rico:Family ;
	rdfs:label "Familie Boissevain" . 
```

Elk ding heeft hier een rdfs:label gekregen. Dat is handig omdat alle tools die linked data 'doen' hiermee overweg kunnen.

Lees ook de data over dit archief in, in GraphDB.

### Les 4
Bekijk wat je nu hebt ingelezen in je repo van GraphDB.

Kies Explore -> Graphs overview. Je ziet nu een overzicht van alle grafen die je in deze repo hebt opgenomen. Als je niet speciaal je best hebt gedaan om je triples in aparte grafen te groeperen, zie je alleen de default graph. Als je op de naam van de graaf klikt, zie je welke triples er allemaal in de graaf zijn opgenomen. Ze zijn gepresenteerd als een tabel met vier kolommen, waarvan de eerste drie subject, predicate en object zijn.

Kies Explore -> Visual Graph. Je kunt nu een URI van een knoop invoeren, we kiezen ```https://id.archief.amsterdam/2```. Je ziet nu een visuele weergave van je graaf.

### Les 5
Hieronder is een complete beschrijving van een archief.

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

<https://id.archief.amsterdam/4> 
	rdf:type rico:RecordSet ;
	rdfs:label "Archief van Een Of Ander Instituut" ;
	rico:hasRecordSetType ric-rst:Fonds ;
    rico:hasAccumulator <https://id.archief.amsterdam/5> ;
    rico:hasOrHadIdentifier [
        a rico:Identifier ;
        rico:hasIdentifierType <https://id.archief.amsterdam/6> ; 
        rico:textualValue "395"
    ] ;
    rico:hasOrHadTitle [
        a rico:Title ;
        rico:textualValue "Archief van Een Of Ander Instituut"
    ] ;
    rico:isAssociatedWithDate [
        a rico:DateRange ;
        rico:expressedDate "1823 - 1972" ;
        rico:hasBeginningDate [
            a rico:SingleDate ;
            rico:normalizedDateValue "1823"^^xsd:gYear
        ] ;
        rico:hasEndDate [
            a rico:SingleDate ;
            rico:normalizedDateValue "1972"^^xsd:gYear
        ]
    ] ;
    rico:isOrWasDescribedBy [
        a rico:Record ;
        rico:hasDocumentaryFormType <https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#FindingAid> ;
        rico:hasOrHadTitle [
            a rico:Title ;
            rico:textualValue "Inventaris van het Archief van Een Of Ander Instituut"
        ] ;
        rico:hasPublisher <https://id.archief.amsterdam/7> ;
    ] ;
    rico:scopeAndContent "blabla" .

<https://id.archief.amsterdam/5>
	a rico:Organization ;
	rdfs:label "Een Of Ander Instituut" .

<https://id.archief.amsterdam/6>
	a rico:IdentifierType ;
	rdfs:label "Toegangsnummer" .

<https://id.archief.amsterdam/7>
	a rico:Organization ;
	rdfs:label "Stadsarchief Amsterdam" .


```

Je ziet hier een heleboel _blanknodes_. Omdat deze geen naam hebben kan GraphDB ze niet visualiseren, en kun je ook niet rechtstreeks aan ze refereren. Maar ze zijn er wel. Er is nu dus een pad in de graaf van <https://id.archief.amsterdam/2> naar de begindatum van de vorming. Dit pad volgt deze relaties: rico:isAssociatedWith/rico:hasBeginningDate/rico:normalizedDateValue. 

## SPARQL

### Les 1
SPARQL is een query-taal die op zoek gaat naar patronen in de graaf. Een SPARQL-query geeft dus altijd antwoord op de vraag: geeft mij alle waardes die voldoen aan het opgegeven patroon. In SPARQL zul je allerlei dingen herkennen uit turtle en -als je dat kent- SQL.

```
SELECT ?archief WHERE {
     ?archief   rdf:type rico:RecordSet ;
                rico:hasRecordSetType ric-rst:Fonds .
}

```

Deze query geeft een lijst terug van URI's waarvan in de graaf is aangegeven dat het een rico:RecordSet is en dat het met de property rico:hasRecordSetType aan ric-rst:Fonds is gekoppeld.

Knip en plak deze query in GraphDB -> SPARQL .

### Les 2
```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType $rst ;
}

```

### Les 3
```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType $rst ;
     		rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
}

```

### Les 4
```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType $rst ;
     		rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
     FILTER (?begindate < '1600'^^xsd:gYear)
}

```

### Les 5
Voeg toe aan de graaf:

```
<https://id.archief.amsterdam/8> 
	rdf:type rico:RecordSet ;
    rico:isAssociatedWithDate [
        a rico:DateRange ;
        rico:expressedDate "1572 - 1798" ;
        rico:hasBeginningDate [
            a rico:SingleDate ;
            rico:normalizedDateValue "1572"^^xsd:gYear
        ] ;
        rico:hasEndDate [
            a rico:SingleDate ;
            rico:normalizedDateValue "1798"^^xsd:gYear
        ]
    ] .

```

en voer dezelfde query opnieuw uit:

```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType $rst ;
     		rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
     FILTER (?begindate < '1600'^^xsd:gYear)
}

```

Waarom komt de nieuwe archiefbeschrijving nu niet als resultaat uit de query? Hint: heeft deze beschrijving een rico:hasRecordSetType property?

Deze query doet het beter:

```
SELECT * WHERE {
     ?rs	rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
     OPTIONAL { ?rs 	rico:hasRecordSetType $rst ; }
     FILTER (?begindate < '1600'^^xsd:gYear)
}

```


## Datastructuur

### Les 1
Je mag in Linked Data alle properties gebruiken die je wilt. We hebben tot nu toe gebruik gemaakt van rdf, rdfs en rico. Een veel toegepaste andere verzameling van properties is schema.org.

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

## Memorix

### RecordTypes

### Records

