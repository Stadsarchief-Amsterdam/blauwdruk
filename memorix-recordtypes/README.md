# voortgang record types

Wat is de stand van zaken mbt de recordtypes en wie is waarmee klaar of bezig.

| Bestand | Veld definities | Vertaling Rico/andere standaard | Te doen | Klaar voor Picturae
| ------- | --------------- | -------------- | ------- | --------
| Afbeelding.ttl  | af | af | - | ja
| Organisatie.ttl  | ja | ja | - | ja
| Persoon.ttl  |  af | af | - | ja
| Familie.ttl  |  af | af | - | ja
| Aanwinst.ttl     | af | af | concept schemes nakijken | 
| Archiefblok.ttl | af| af | - | ja
| Groep.ttl     | af | af | - | ja
| Bestanddeel.ttl     | af | af | - | ja
| Informatieobject.ttl     | af | af | concept schemes nakijken | ja
| InformatieobjectOnderdeel.ttl     | af | af | concept schemes nakijken | ja
| Akte.ttl     | ja | ja | concept schemes nakijken
| Persoonsvermelding.ttl     | ja | ja | - | ja
| Boek.ttl     | - | - | -
| Periodiek.ttl     | - | - | -
| Aflevering.ttl     | - | - | -
| Auteur.ttl     | - | - | -
| CooperatiefAuteur.ttl     | - | - | -
| AV.ttl     | - | - | na migratie
| MAI.ttl     | - | - | na migratie
| Duplicaat.ttl     | - | - | -
| Conserveringsrapport.ttl     | ja | ja | -
| Bruikleen.ttl     | ja | - | -


## Andere richtlijnen
Om een record in Memorix een rdf:type van een bepaald Class te laten zijn volstaat de sh:targetClass property met Object een IRI naar de class, b.v.:

    <> sh:targetClass <http://schema.org/Brand> .

Dit resulteert in een record met 3 rdf:type waardes:
    
    </recordtypes/Brand>
    <http://schema.org/Brand>
    <http://memorix.io/ontology#Record>


## regels voor de Saa SHACL
* alles behalve Class namen camelCase
* properties leggen we vast in het Engels
* minCount 0 is overbodig, maxCount oneindig is overbodig in Shacl maar we hebben maxCount >1 nodig om in Memorix een herhaalbaar blok te kunnen maken. Dus we spreken af: **altijd maxCount** opnemen.
* als we zeker weten dat iets een xsd:Date is, voor nu geen Memorix:dateEditor opnemen (want die werkt alleen met ints)

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