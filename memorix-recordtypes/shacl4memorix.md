# shacl4memorix.md

## Dit mapje
Dit mapje bevat alleen maar experimenten en schrijft op geen enkele manier voor hoe het gaat worden.

## Geleerd over Memorix:
(Deze tekst is nog lang niet uitgewerkt en vooral mijn opsomming van dingen die ik ervaren heb bij het experimenteren)

* dc:identifier is verplicht en de waarde wordt gebruikt voor de unieke naam in het systeem. Het resulteert uiteindelijk in de naam van de memorix:Recordtype. Het mag geen taaldeclaratie bevatten want dan krijg je een foutmelding.

* sh:group is verplicht

* @prefix voor de sh:NodeShapes/memorix:Recordtype's MOET /resources/recordtypes/ (relatief pad?) zijn.

* Als je een class wilt gebruiken om een knoop in het pad te willen definieren, moet je sh:BlankNode gebruiken

* Bij het maken van details moet de class mee opgeslagen worden dat gebeurt door de sh:targetClass. 

* Er mag maar e1n memorix:Recordtype in de request zitten. 

* ??? er staat nu in de voorbeelden vaak een owl:equivalentClass relatie met een blanknode van een type en een gestandaardiseerde property. Zou dat niet bestaatvastniet:equivalentIndividual/owl:sameAs moeten zijn? 

* Voor het koppelen van een link is sh:or verplicht, ook als het maar e1n class is die je wilt koppelen.