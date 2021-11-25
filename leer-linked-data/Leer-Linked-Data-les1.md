# Leer Linked Data

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

