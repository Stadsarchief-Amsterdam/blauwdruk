# Leer Linked Data

## Datastructuur

### Les 1
Je mag in Linked Data alle properties gebruiken die je wilt. We hebben tot nu toe gebruik gemaakt van property-verzamelingen rdf, rdfs en rico. Een veel toegepaste andere verzameling van properties is schema.org.

Zo'n verzameling van properties heeft een bepaalde samenhang. In rico is het bijvoorbeeld logisch dat een knoop van het type rico:RecordSet de property rico:hasRecordSetType mag hebben. Dit soort samenhang wordt vastgelegd in een _ontologie_. Van elke property is bijvoorbeeld vastgelegd wat de _domain_ is, en de _range_. De domain van de property rico:hasRecordSetType is rico:RecordSet en de object van een triple met deze property is van het type rico:RecordSetType, met andere woorden: de range van rico:hasRecordSetType is rico:RecordSetType.

Lees de rico-ontologie in in GraphDB:
"Import" -> "RDF" -> "Get RDF data from a URL"

Gebruik deze URL en kies bij het inlezen voor 'named graph'.
https://www.ica.org/standards/RiC/RiC-O_v0-2.rdf 

Geef de graaf de naam "https://www.ica.org/standards/RiC/ontology".

Als je nu een graaf gaat visualiseren, zie je rdfs:labels die zijn gedefinieerd in de ontologie bij de relaties staan.

### Les 2
Zo'n ontologie helpt om allerlei queries te kunnen stellen die eerst niet mogelijk waren. De triple store (in ons geval GraphDB) maakt daarbij gebruik van 'reasoning'. Bij dit 'redeneren' leidt de triple store extra relaties af die je niet expliciet hebt opgegeven in je data. Dit afleiden heet 'inference'. Daarbij maakt het systeem gebruik van de onderlinge relaties tussen concepten en properties die in de ontologie zijn vastgelegd. Dit klinkt heel abstact, daarom gaan we daarmee oefenen. Om te oefenen met de mogelijkheden die er zijn om onderlinge relaties tussen concepten en properties te leggen maken een we aparte repo aan. We geven daarbij aan dat we RDFS willen gebruiken voor de 'reasoning'.

Setup -> Repositories -> Create New Repository

1. Geef de repo een naam
2. Selecteer RDFS als 'ruleset' voor de 'inference'.
3. Vink aan: 'Supports SHACL validation'

Lees in je repo dit voorbeeld in:

```
@prefix ex: <http://example.com/example#> .

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

# ontology
ex:SportsTeam a rdfs:Class .
ex:Player a rdfs:Class .
ex:playsIn a rdfs:Property .

# data
ex:Tadic ex:playsIn ex:Ajax .
ex:Mitton ex:playsIn ex:AHBC .
```

Opdracht: leg uit wat we hier hebben vastgelegd. Kun je nog meer semantiek bedenken die we niet gecodeerd hebben? Wat is ex:AHBC voor club?

### Les 3

Voeg toe:
```
@prefix ex: <http://example.com/example#> .

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

# ontology
ex:FootballTeam a rdfs:Class ;
    rdfs:subClassOf ex:SportsTeam .

# data
ex:Ajax a ex:FootballTeam .
```

Dit maakt de volgende queries mogelijk:

SPARQL:
```
PREFIX ex: <http://example.com/example#> 

SELECT * WHERE {
    ?s ex:playsIn ?o .
    ?o a ex:FootballTeam .
}
```
en
```
PREFIX ex: <http://example.com/example#> 

SELECT * WHERE {
    ?s ex:playsIn ?o .
    ?o a ex:SportsTeam .
}
```

Opdracht: waar staat dat Ajax een Sportsteam is? Is deze kennis afgeleid (impliciet) of direct vastgelegd (expliciet)?

Opdracht: wat mist er volgens jou als je als mens de semantiek van de relaties interpreteert?

### Les 4
Dus voeg toe:

```
@prefix ex: <http://example.com/example#> .

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

# ontology
ex:HockeyTeam a rdfs:Class ;
    rdfs:subClassOf ex:SportsTeam .

# data
ex:AHBC a ex:HockeyTeam .
```

```
PREFIX ex: <http://example.com/example#> 

SELECT * WHERE {
    ?s ex:playsIn ?o .
    ?o a ex:SportsTeam .
}
```

Opdracht: handig he!?

### Les 5
Voeg toe:
```
@prefix ex: <http://example.com/example#> .

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

# ontology
ex:playsIn a rdfs:Property ;
    rdfs:domain ex:Player ;
    rdfs:range ex:SportsTeam .

```

SPARQL:
```
PREFIX ex: <http://example.com/example#> 

SELECT ?s WHERE {
    ?s a ex:Player .
}
```

### Les 6
Extra stof: bekijk de RiC-O ontologie. Deze is [oorspronkelijk in RDF/XML](RiC-O_v0-2.rdf) (de oudste en dus ouderwetse serializatie), maar heb ik voor de gelegenheid [geconverteerd naar Turtle](RiC-O_v0-2.ttl).

'owl' staat voor Web Ontology Language (de grap is dat de Uil in Winnie de Pooh zijn naam schreef als "WOL"). OWL is een uitbreiding van RDFS, waardoor er nog meer soorten structuren kunnen worden gedefinieerd.

Voorbeeld: 
1. zoek (ctrl-F) op :hasAccumulator. Kijk wat de domain en range is.
2. zoek op :Record. 

### Bijlage compleet voorbeeld

```
@prefix ex: <http://example.com/example#> .

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

# ontology
ex:SportsTeam a rdfs:Class .

ex:FootballTeam a rdfs:Class ;
    rdfs:subClassOf ex:SportsTeam .

ex:HockeyTeam a rdfs:Class ;
    rdfs:subClassOf ex:SportsTeam .

ex:Player a rdfs:Class .

ex:playsIn a rdfs:Property ;
    rdfs:domain ex:Player ;
    rdfs:range ex:SportsTeam .

# data
ex:Tadic ex:playsIn ex:Ajax .
ex:Mitton ex:playsIn ex:AHBC .

ex:Ajax a ex:FootballTeam .
ex:AHBC a ex:HockeyTeam .
```
