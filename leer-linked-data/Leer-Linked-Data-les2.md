# Leer Linked Data

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


