# Leer Linked Data

## Memorix

### Les 1
Er zijn een aantal aanvullingen noodzakelijk om van een graaf met shapes in SHACL een formulier in een gebruikersinterface te kunnen genereren. De volgende zaken zijn daarbij van belang:
* een label om bij het veld op het formulier te laten zien
* de volgorde waarin de velden in het formulier moeten worden opgenomen
* eventueel een groepering van de velden

Al deze zaken zijn gedefinieerd in SHACL zelf, rdfs:label, sh:order, sh:group.

Dus, bijvoorbeeld:
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl:           <http://www.w3.org/2002/07/owl#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .

blauwdruk:VeldenGroep a sh:PropertyGroup ;								# <======
	rdfs:label "Groepering van de velden"@nl ;							# <======
    sh:order 1.0 .														# <======

blauwdruk:FondsTest a sh:NodeShape , owl:Class ;
    sh:targetClass blauwdruk:FondsTest ;
    rdfs:subClassOf rico:RecordSet ;
    rdfs:label "Archiefblok" ;
    sh:property [
    	rdfs:label "Archiefnummer"@nl , "Number of the Fonds"@en ;
        sh:path rico:identifier ;
        sh:datatype xsd:integer ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:group blauwdruk:VeldenGroep ;								# <======
        sh:order 1.0 													# <======
    ] ;
    sh:property [
    	rdfs:label "Beschrijving"@nl , "Title"@en ;
        sh:path rico:title ;
        sh:datatype xsd:string ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:group blauwdruk:VeldenGroep ;								# <======
        sh:order 2.0 													# <======
    ] ;
    sh:property [
    	rdfs:label "Begindatum archiefvorming"@nl , "Beginning date Accumulation"@en ;
        sh:path rico:beginningDate ;
        sh:datatype xsd:date ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:group blauwdruk:VeldenGroep ;								# <======
        sh:order 3.0 													# <======			
    ] .
```

### Les 2
Ook Picturae heeft als basis voor het definieren van een recordtype SHACL gekozen als standaard. Memorix stelt een paar harde eisen aan de recordtype definitie.
* sh:order, sh:group en rdfs:label (zie hierboven) zijn verplicht bij een property
* een sh:NodeShape moet *ook* gedefinieerd worden als een memorix:Recordtype.
* Een memorix:Recordtype *moet* bevatten: dc:identifier, sh:ignoredProperties en sh:closed (deze laatste moet true zijn).
* er moet een dynamisch pad zijn in de prefix

Dus:
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl:           <http://www.w3.org/2002/07/owl#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .
@prefix dc:            <http://purl.org/dc/elements/1.1/> .					# <======
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix dash:          <http://datashapes.org/dash#> .						# <======
@prefix memorix:       <http://memorix.io/ontology#> .						# <======
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix blauwdruk:     </resources/recordtypes/> .							# <======

blauwdruk:VeldenGroep a sh:PropertyGroup ;
	rdfs:label "Groepering van de velden"@nl ;
    sh:order 1.0 .

blauwdruk:Blablabla a sh:NodeShape , owl:Class , memorix:Recordtype;		# <======
    sh:targetClass blauwdruk:Blablabla ;
    rdfs:subClassOf rico:RecordSet ;
    rdfs:label "Archiefblok" ;
    dc:identifier "FondsTest" ;												# <======
    sh:ignoredProperties ( rdf:type ) ;										# <======
    sh:closed true ;														# <======
    sh:property [
    	rdfs:label "Archiefnummer"@nl , "Number of the Fonds"@en ;
        sh:path rico:identifier ;
        sh:datatype xsd:integer ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:group blauwdruk:VeldenGroep ;
        sh:order 1.0
    ] ;
    sh:property [
    	rdfs:label "Beschrijving"@nl , "Title"@en ;
        sh:path rico:title ;
        sh:datatype xsd:string ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:group blauwdruk:VeldenGroep ;
        sh:order 2.0
    ] ;
    sh:property [
    	rdfs:label "Begindatum archiefvorming"@nl , "Beginning date Accumulation"@en ;
        sh:path rico:beginningDate ;
        sh:datatype xsd:date ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
        sh:group blauwdruk:VeldenGroep ;
        sh:order 3.0
    ] .
```

Het leuke is: om de RecordType SHACL file te controleren heeft Picturae zelf een SHACL-file ingebouwd ...

### Les 3
Op basis van het memorix:Recordtype uit les 2 genereert Memorix dit record:

```
@prefix blauwdruk: <https://example.memorix-test.nl/resources/recordtypes/> .
@prefix dash:      <http://datashapes.org/dash#> .
@prefix dc:        <http://purl.org/dc/elements/1.1/> .
@prefix dcterms:   <http://purl.org/dc/terms/> .
@prefix fondsTest: <https://example.memorix-test.nl/resources/recordtypes/FondsTest#> .
@prefix memorix:   <http://memorix.io/ontology#> .
@prefix owl:       <http://www.w3.org/2002/07/owl#> .
@prefix rdf:       <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:      <http://www.w3.org/2000/01/rdf-schema#> .
@prefix rico:      <https://www.ica.org/standards/RiC/ontology#> .
@prefix schema:    <http://schema.org/> .
@prefix sh:        <http://www.w3.org/ns/shacl#> .
@prefix skos:      <http://www.w3.org/2004/02/skos/core#> .
@prefix xsd:       <http://www.w3.org/2001/XMLSchema#> .

<https://example.memorix-test.nl/resources/records/cb9bb7f0-694b-4689-8e8c-2a42d607996f>
        rdf:type            blauwdruk:FondsTest , memorix:Record ;
        rico:beginningDate  "2021-12-08"^^xsd:date ;
        rico:identifier     4 ;
        rico:title          "Archief van Ivo" .
```

### Les 4
Om Memorix goed te laten functioneren, moet je wel een aantal specifieke dingen toevoegen. 

*memorix:inTitleAt* zorgt ervoor dat dit veld wordt opgenomen in het kopje van het record bovenaan de pagina als je het record in Memorix bekijkt. Je geeft een waarde op, om de volgorde vast te leggen. *memorix:inSummaryAt* doet hetzelfde voor de samenvatting die in een record overzicht wordt weergegeven. Dat zou dus anders kunnen zijn dan de 'Title'.

Je kunt met *dash:editor* verwijzen naar een speciale invoermogelijkheid voor een speciale situatie. Om een link te leggen met een ander recordtype binnen Memorix biedt Picturae bijvoorbeeld *memorix:LinkedRecordEditor* aan. Voor een link met een externe terminologiebron is er *memorix:VocabularyEditor*.

Voor een compleet voorbeeld klik [hier](memorix-recordtype-example.ttl).

