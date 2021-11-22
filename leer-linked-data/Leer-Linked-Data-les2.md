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

Deze query geeft een lijst terug van URI's waarvan in de graaf is aangegeven dat het een rico:RecordSet is en dat het met de property rico:hasRecordSetType aan ric-rst:Fonds is gekoppeld. Het resultaat is een tabel met een kolom. Als header van deze kolom staat de naam van de variabele die je hebt gekozen: in dit geval _?archief_.

Knip en plak deze query in GraphDB -> SPARQL .

### Les 2
Je kunt meerdere variabelen gebruiken in je query. Als je het sterretje gebruikt worden alle variabelen in de tabel weergegeven. Deze query levert dus twee kolommen op, met ?rs en ?rst in de header.

```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType ?rst ;
}

```

Deze query geeft alle combinaties van knopen in de graaf waarbij de relatie _rico:hasRecordSetType_ is.

### Les 3
Het patroon dat je zoekt in de graaf kan ook een _pad_ zijn, van de ene knoop naar de andere, langs verschillende properties. Zoals in deze query:

```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType ?rst ;
     		rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
}

```

Merk op dat je hier de syntax van turtle gebruikt: doordat er een punt-komma staat herhaal je als het ware de variabele ?rs. Deze query is dus precies hetzelfde als deze:

```
SELECT * WHERE {
     ?rs rico:hasRecordSetType ?rst .
     ?rs rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
}

```

Merk op dat alle resultaten die je ziet voldoen aan allebei deze voorwaardes. Er wordt alleen een Recordset gegeven voor ?rs als deze met iets is verbonden via rico:hasRecordSetType *en* daarnaast ook met iets via het hele pad van de tweede regel van de query.

### Les 4
Nu een beetje nuttige query: stel je bent mediaevist en wilt alleen maar *echt* oude dingen:

```
SELECT * WHERE {
     ?rs 	rico:hasRecordSetType ?rst ;
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
     ?rs 	rico:hasRecordSetType ?rst ;
     		rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
     FILTER (?begindate < '1600'^^xsd:gYear)
}

```

Waarom komt de nieuwe archiefbeschrijving nu niet als resultaat uit de query? Hint: heeft deze beschrijving een rico:hasRecordSetType property?

Deze query doet het beter:

```
SELECT * WHERE {
     ?rs rico:isAssociatedWithDate/rico:hasBeginningDate/rico:normalizedDateValue ?begindate .
     OPTIONAL { ?rs rico:hasRecordSetType ?rst ; }
     FILTER (?begindate < '1600'^^xsd:gYear)
}

```

Nu zie je dat een cel in de kolom onder ?rst leeg is als deze niet in de data aanwezig is.
