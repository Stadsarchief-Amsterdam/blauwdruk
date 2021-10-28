# voortgang record types

Wat is de stand van zaken mbt de recordtypes en wie is waarmee klaar of bezig.
Zo lang we nog alleen de beschikking hebben over de example omgeving stel ik voor even alles te prefixen met Saa (anders word ik gek).

| Bestand | Veld definities | Vertaling Rico | Te doen | Klaar voor Picturae
| ------- | --------------- | -------------- | ------- | --------
| Afbeelding.ttl  | - | - | - | ja
| Organisatie.ttl  | - | - | Levensloop toevoegen? | ja
| Persoon.ttl  |  af | - | | ja
| Familie.ttl  |  af |  | | ja
| Aanwinst.ttl     | - | - | P mee bezig
| Archiefblok.ttl | af| - | Opnieuw met Ivo door kijken | -
| Groep.ttl     | - | - | -
| Bestanddeel.ttl     | - | - | -
| Informatieobject.ttl     | - | - | -
| InformatieobjectOnderdeel.ttl     | - | - | -
| Akte.ttl     | - | - | -
| Persoonsvermelding.ttl     | - | - | -
| Publicatie.ttl     | - | - | -
| AV.ttl     | - | - | -
| MAI.ttl     | - | - | -
| Conservering.ttl     | - | - | Moet deze gemaakt?

## Vragen Picturae
* dash:singleLine  true ; is dit niet de default?
* hoe zorgen we ervoor dat sommige velden niet online komen? Zoals bv de interne opmerkingen
* enum velden, kan zoiets voor een status veld, zonder dat er waardes in een concept scheme komen?
* hoe de indeling parent vast te leggen?

## todo
* inTitleAt and inSummaryAt nalopen en vastleggen
* verplichte velden
* example uri overal afhalen


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