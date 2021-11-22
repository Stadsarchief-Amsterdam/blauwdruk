# Leer Linked Data

## Memorix

### RecordTypes
Ik heb een voorbeeld recordtype aangemaakt door de volgende recordtype definitie in te lezen in een test-omgeving van Memorix. We gaan stapje voor stapje na wat er allemaal in wordt uitgedrukt. Maar eerst kun je eens kijken hoe deze recordtype definitie er in Memorix uitziet.

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl:           <http://www.w3.org/2002/07/owl#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .

@prefix dc:            <http://purl.org/dc/elements/1.1/> .
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix dash:          <http://datashapes.org/dash#> .
@prefix memorix:       <http://memorix.io/ontology#> .

@prefix rt:            </resources/recordtypes/> .
@prefix archiefblok:   </resources/recordtypes/ArchiefblokDemonstratie#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .

rt:Archiefblok a sh:NodeShape, memorix:Recordtype ;
    rdfs:label           "Archiefblok"@nl ;
    rdfs:comment         "Stadsarchief recordtype voor Archiefblok"@nl ;
    dc:identifier        "ArchiefblokDemonstratie" ;
    sh:targetClass       rt:Archiefblok ;
    owl:equivalentClass  rico:RecordSet ;
    sh:closed            true ;
    sh:ignoredProperties ( rdf:type ) ;
    sh:property          [ rdfs:label        "Nummer Toegang"@nl ;
                           rdfs:comment      "Unieke nummer van deze toegang"@nl ;
                           sh:minCount       1 ;
                           sh:maxCount       1 ;
                           sh:group          archiefblok:identificationGroup ;
                           sh:order          1.0 ;
                           memorix:inTitleAt 1 ;
                           sh:path           rico:identifier ;
                           sh:message        "Een nummer is verplicht en moet een getal zijn."@nl ;
                           sh:datatype       xsd:integer ] ;
    sh:property          [ rdfs:label        "Naam Toegang"@nl ;
                           rdfs:comment      "Naam of beschrijving van het archiefblok."@nl ;
                           sh:minCount       1 ;
                           sh:maxCount       1 ;
                           sh:group          archiefblok:identificationGroup ;
                           sh:order          2.0 ;
                           memorix:inTitleAt 2 ;
                           sh:path           rico:title ;
                           sh:message        "Naam toegang is verplicht. Moet altijd beginnen met 'Archief' of 'Collectie.'"@nl ;
                           sh:datatype       xsd:string ] .

archiefblok:identificationGroup a sh:PropertyGroup ;
    rdfs:label "Identificatie"@nl ;
    sh:order   1.0 .

```

Vul [hier](https://example.memorix-test.nl/ui/collections/eac29c25-1015-40c8-b40f-15391525cde7/record/new-ArchiefblokDemonstratie) data in over een test archief.

1. Kun je ook een letter proberen in te voeren voor het nummer van de toegang?
1. Kijk wat er gebeurt als je vergeet een titel in te voeren?
1. 

### Records
