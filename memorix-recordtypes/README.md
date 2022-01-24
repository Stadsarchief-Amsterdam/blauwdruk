# voortgang record types

Wat is de stand van zaken mbt de recordtypes en wie is waarmee klaar of bezig.
Zo lang we nog alleen de beschikking hebben over de example omgeving stel ik voor even alles te prefixen met Saa (anders word ik gek).

| Bestand | Veld definities | Vertaling Rico/andere standaard | Te doen | Klaar voor Picturae
| ------- | --------------- | -------------- | ------- | --------
| Afbeelding.ttl  | af | af | - | ja
| Organisatie.ttl  | - | - | Levensloop toevoegen? | ja
| Persoon.ttl  |  af | af | | ja
| Familie.ttl  |  af | af | | ja
| Aanwinst.ttl     | af | af | voorstel: acquisition:isDescribedIn vervangen door acquisition:resultsIn | 
| Archiefblok.ttl | af| af | - | ja
| Groep.ttl     | af | af | - | ja
| Bestanddeel.ttl     | af | af | - | ja
| Informatieobject.ttl     | af | af | - | -
| InformatieobjectOnderdeel.ttl     | af | af | - | -
| Akte.ttl     | nee | - | adressen toevoegen, en vertalen
| Persoonsvermelding.ttl     | ja | ja | -
| Boek.ttl     | - | - | -
| Periodiek.ttl     | - | - | -
| Aflevering.ttl     | - | - | -
| AV.ttl     | - | - | -
| MAI.ttl     | - | - | -
| Duplicaat.ttl     | - | - | -
| Restauratierapport.ttl     | - | - | -
| Bruikleen.ttl     | - | - | -


## Andere richtlijnen
Om een record in Memorix een rdf:type van een bepaald Class te laten zijn volstaat de sh:targetClass property met Object een IRI naar de class, b.v.:

    <> sh:targetClass <http://schema.org/Brand> .

Dit resulteert in een record met 3 rdf:type waardes:
    
    </recordtypes/Brand>
    <http://schema.org/Brand>
    <http://memorix.io/ontology#Record>


## Vragen Picturae
* dash:singleLine  true ; is dit niet de default?
* hoe zorgen we ervoor dat sommige velden niet online komen? Zoals bv de interne opmerkingen
* enum velden, kan zoiets voor een status veld, zonder dat er waardes in een concept scheme komen?
* hoe de indeling parent vast te leggen?

## regels voor de Saa SHACL
* alles behalve Class namen camelCase
* properties leggen we vast in het Engels
* minCount 0 is overbodig, maxCount oneindig is overbodig in Shacl maar we hebben maxCount >1 nodig om in Memorix een herhaalbaar blok te kunnen maken. Dus we spreken af: **altijd maxCount** opnemen.
* asl we zeker weten dat iets een xsd:Date is, voor nu geen Memorix:dateEditor opnemen (want die werkt alleen met ints)

## todo
* inTitleAt and inSummaryAt nalopen en vastleggen
* verplichte velden

## UI spul Memorix

op dit moment zijn er maar enkele dash:Editors.
* dash:TextFieldEditor (default met datatype xsd:string)
* dash:TextAreaEditor voor textarea op xsd:string
* memorix:DateEditor ; voor xsd:int om de 3 boxjes voor datum te renderen
* memorix:VocabularyEditor ; om naar skos concepten te linken.
* memorix:LinkedRecordEditor ; om naar records te linken

Op dit moment worden alleen de volgende datatypes ondersteund op de backend.
* xsd:string
* xsd:date
* xsd:gYear
* xsd:gYearMonth
* xsd:boolean
* xsd:integer

## Geleerd over Memorix:
(Deze tekst is nog lang niet uitgewerkt en vooral een opsomming van dingen die we ervaren heb bij het experimenteren)

* dc:identifier is verplicht en de waarde wordt gebruikt voor de unieke naam in het systeem. Het resulteert uiteindelijk in de naam van de memorix:Recordtype. Het mag geen taaldeclaratie bevatten want dan krijg je een foutmelding.

* sh:group is verplicht

* @prefix voor de sh:NodeShapes/memorix:Recordtype's MOET /resources/recordtypes/ (relatief pad) zijn.

* Als je een class wilt gebruiken om een knoop in het pad te willen definieren, moet je sh:BlankNode gebruiken

* Bij het maken van details moet de class mee opgeslagen worden dat gebeurt door de sh:targetClass. 

* Er mag maar e1n memorix:Recordtype in de request zitten. 

* Voor het koppelen van een link is sh:or verplicht, ook als het maar e1n class is die je wilt koppelen.