# Leer Linked Data

## Datastructuur in SHACL

Maak ter voorbereiding een nieuwe repository aan.
Setup -> Repositories -> Create New Repository

1. Geef de repo een naam
2. Vink aan: 'Supports SHACL validation'

### Les 1
Een ontologie verschilt van een datamodel in dat er in een ontologie (en daarmee volgens de principes van Linked Data) geen verplichtingen zijn over welke properties er wel of niet zijn. Deze vrijheid die Linked Data biedt is niet altijd handig. Soms moet je gewoon zeker weten dat er een plaats in het depot is vastgelegd bijvoorbeeld. En ook kunnen controleren dat dit verplichte veld is ingevuld. Daarvoor gebruiken we SHACL (Shapes Constraint Language). Bij het Stadsarchief Amsterdam stellen we bijvoorbeeld als randvoorwaarde (_constraint_) dat bij een Archiefblok precies 1 archiefvormer moet worden vastgelegd. In SHACL leggen we dat als volgt vast:

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .

blauwdruk:Fonds a sh:NodeShape;
    sh:targetClass rico:RecordSet ;
    rdfs:label "Archiefblok" ;
    sh:property [
        sh:path rico:hasAccumulator ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
    ] .
```

Lees deze graaf in. Dus: "Import" -> "RDF" -> "Import RDF Text Snippet" . Kies bij het importeren als naam voor de graaf: http://rdf4j.org/schema/rdf4j#SHACLShapeGraph. Deze graaf van Shapes is niet meer terug te zien in de lijst van geimporteerde grafen maar door het deze naam te geven weet GraphDB dat ze de shapes in de graaf moet gebruiken om te valideren bij het importeren.


### Les 2
Als het goed is, gaat het nu mis als je onderstaande data wilt invoeren
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .

<https://id.archief.amsterdam/8>
	rdf:type rico:RecordSet ;
    rdfs:label "Het Archief van het Weeshuis" ;
	rico:hasRecordSetType ric-rst:Fonds .
```

Opdracht: probeer het in te voeren in je repo en kijk wat er gebeurt.
Opdracht: voeg een triple toe waardoor aan de NodeShape hierboven is voldaan.

Antwoord:
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .

<https://id.archief.amsterdam/8>
    rdf:type rico:RecordSet ;
    rdfs:label "Het Archief van het Weeshuis" ;
    rico:hasAccumulator "Het Weeshuis" ;
    rico:hasRecordSetType ric-rst:Fonds .
```

### Les 3
De _inference_ die we hebben leren kennen in de les over ontologieen werkt natuurlijk pas goed als de data correct is. En een foutje is zo gemaakt. Daarom is het handig om bij zoveel mogelijk data aan te geven welke rdfs:Class de entiteit heeft. SHACL kan voor je controleren of je daarin geen fouten gemaakt hebt. Als er geen sprake is van een entiteit die is gekoppeld, kun je ook het datatype vastleggen.

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .

blauwdruk:Fonds a sh:NodeShape ;
    sh:targetClass rico:RecordSet ;
    rdfs:label "Archiefblok" ;
    sh:property [
        sh:path rico:hasAccumulator ;
        sh:class rico:Agent ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
    ] ;
    sh:property [
        sh:path rico:beginningDate ;
        sh:datatype xsd:date ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
    ] .
```

Opdracht: importeer deze nieuwe NodeShape. Dus: "Import" -> "RDF" -> "Import RDF Text Snippet" . Kies bij het importeren als naam voor de graaf: http://rdf4j.org/schema/rdf4j#SHACLShapeGraph. Vink aan: "Enable replacement of exisitng data". Merk op dat na het importeren de oude data niet meer wordt gevalideerd. Dat gebeurt in GraphDB blijkbaar alleen bij het inlezen.

Opdracht: er is een punt waarop onderstaande voorbeeld niet zal valideren tegen de NodeShape die we hierboven hebben gedefinieerd. Welk punt is dat?

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .

<https://id.archief.amsterdam/8>
    rdf:type rico:RecordSet ;
    rdfs:label "Het Archief van het Weeshuis" ;
    rico:hasAccumulator [
        rdf:type rico:CorporateBody ;
        rdfs:label "Het Weeshuis" ;
        ] ;
    rico:beginningDate "1673-02-28"^^xsd:date ;
    rico:hasRecordSetType ric-rst:Fonds .
```

Antwoord:
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .

<https://id.archief.amsterdam/8>
    rdf:type rico:RecordSet ;
    rdfs:label "Het Archief van het Weeshuis" ;
    rico:hasAccumulator [
        rdf:type rico:Agent ;
        rdfs:label "Het Weeshuis" ;
        ] ;
    rico:beginningDate "1673-02-28"^^xsd:date ;
    rico:hasRecordSetType ric-rst:Fonds .
```

Dit lossen we op door de inference aan te zetten op basis van de RiC-Ontology. In dat geval rekent GraphDB eerst uit dat het Weeshuis een rico:Agent is omdat ```rico:CorporateBody owl:subClassOf rico:Group . rico:Group owl:subClassOf rico:Agent .```. 

### Les 4
Bij het Stadsarchief Amsterdam stellen we andere eisen aan verschillende RecordSet (bijvoorbeeld: archiefvormer verplicht bij blauwdruk:Archiefblok, maar niet bij blauwdruk:Groep) of een Record (we willen een vervaardiger bij blauwdruk:Afbeelding, maar niet bij blauwdruk:Akte).

Daarom definieren we onze eigen Classes, die we 'ophangen' in de RiC-O ontologie. We kunnen dan gebruik maken van de mogelijkheden die de ontologie ons biedt en onze eigen eisen stellen aan onze eigen data. Dat kan in een aparte ontologie, maar we hebben er bij het SAA voor gekozen om deze ontologische uitspraken en de NodeShapes te combineren in een ding:

```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl:           <http://www.w3.org/2002/07/owl#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .
@prefix sh:            <http://www.w3.org/ns/shacl#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix blauwdruk:     <https://id.archief.amsterdam/recordtypes/> .

blauwdruk:Fonds a sh:NodeShape , owl:Class ;
    sh:targetClass blauwdruk:Fonds ;
    rdfs:subClassOf rico:RecordSet ;
    rdfs:label "Archiefblok" ;
    sh:property [
        sh:path rico:hasAccumulator ;
        sh:class rico:Agent ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
    ] ;
    sh:property [
        sh:path rico:beginningDate ;
        sh:datatype xsd:date ;
        sh:minCount 1 ;
        sh:maxCount 1 ;
    ] ;
    sh:property [
        sh:path blauwdruk:internalRemark ;
        sh:datatype xsd:string ;
    ] .

```

We moeten dan wel ons eigen ding de rdf:type blauwdruk:Fonds meegeven:
```
@prefix rdf:           <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:          <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd:           <http://www.w3.org/2001/XMLSchema#> .
@prefix rico:          <https://www.ica.org/standards/RiC/ontology#> .
@prefix ric-rst:       <https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#> .

<https://id.archief.amsterdam/8>
    rdf:type blauwdruk:Fonds ;
    rdfs:label "Het Archief van het Weeshuis" ;
    rico:hasAccumulator [
        rdf:type rico:Agent ;
        rdfs:label "Het Weeshuis" ;
        ] ;
    rico:beginningDate "1673-02-28"^^xsd:date ;
    rico:hasRecordSetType ric-rst:Fonds .
```

Opdracht: kijk naar de volledige definitie van Archiefblok in de blauwdruk.

### Les 5 
En nu maken we een denksprong. Als we dit soort randvoorwaarden vastleggen in SHACL, kunnen we die randvoorwaarden gebruiken om te valideren, maar legt het ook eenduidig vast hoe het scherm van de gebruikersinterface eruit ziet. Bij de bovenstaande NodeShape zal er dus voor een Archiefblok drie velden op het scherm moeten zijn, en het systeem kan aangeven dat ze niet wil opslaan, als er niet een verplichte archiefvormer en datum zijn ingevuld. We hebben wat aanvullende informatie nodig: we willen de volgorde vastleggen en misschien willen we de velden groeperen in blokken op het scherm. Memorix maakt gebruik van dit idee om drie vliegen in een klap te slaan: met zo'n SHACL-nodeshape-met aanvullingen leggen we de datadefinitie vast, kunnen we de data correct houden en de gebruikersinterface definieren. Volgende keer gaan we daar naar kijken.

