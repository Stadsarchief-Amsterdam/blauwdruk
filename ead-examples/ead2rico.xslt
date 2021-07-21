<?xml version="1.0" encoding="UTF-8"?>

<!-- XSLT stylesheet converting City Archives Amsterdam examples -->
<!-- Endocoded Archival Description 2002 (EAD) into Records in Contexts Ontology (RiC-O) 0.2-->
<!-- Ivo Zandhuis (ivo@zandhuis.nl) 20210719 -->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="https://schema.org/"
    xmlns:rico="https://www.ica.org/standards/RiC/ontology#">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:param name="baseUri">https://data.archief.amsterdam/</xsl:param>
<xsl:param name="baseUrl">https://archief.amsterdam/</xsl:param>

<!-- RDF wrap, looping hierarchy -->
<xsl:template match="ead">
    <rdf:RDF>
        <xsl:apply-templates select="archdesc"/>
    </rdf:RDF>
</xsl:template>

<!-- creating subjects -->
<xsl:template match="archdesc">
    <rico:RecordSet>
        <xsl:attribute name="rdf:about">
            <xsl:value-of select="$baseUri"/>
            <xsl:value-of select="@level"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="did/unitid/@identifier"/>
        </xsl:attribute>
        <xsl:call-template name="set-recordsettype">
            <xsl:with-param name="type" select="@level"/>
        </xsl:call-template>      
        <rico:isOrWasDescribedBy>
            <rico:Record>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="$baseUri"/>
                    <xsl:text>findingaid/</xsl:text>
                    <xsl:value-of select="../eadheader/eadid/@identifier"/>
                </xsl:attribute>
                <rdf:type>
                    <xsl:attribute name="rdf:resource">
                        <xsl:text>https://data.archief.amsterdam/ontology#Inventaris</xsl:text>
                    </xsl:attribute>              
                </rdf:type>
                <rico:hasDocumentaryFormType>
                    <xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/vocabularies/documentaryFormTypes#FindingAid</xsl:attribute>
                </rico:hasDocumentaryFormType>
                <rico:hasOrHadTitle>
                    <rico:Title>
                        <rico:textualValue>
                            <xsl:value-of select="../eadheader/filedesc/titlestmt/titleproper"/>
                        </rico:textualValue>
                    </rico:Title>
                </rico:hasOrHadTitle>
                <rico:hasPublisher>
                    <rico:CorporateBody>
                        <rico:hasOrHadAgentName>
                            <rico:AgentName>
                                <rico:textualValue>
                                    <xsl:value-of select="../eadheader/filedesc/publicationstmt/publisher"/>
                                </rico:textualValue>
                            </rico:AgentName>
                        </rico:hasOrHadAgentName>
                    </rico:CorporateBody>
                </rico:hasPublisher>
            </rico:Record>
        </rico:isOrWasDescribedBy>
        <xsl:apply-templates select="did"/>
    </rico:RecordSet>
    <xsl:apply-templates select="dsc">
        <xsl:with-param name="archnr" select="did/unitid"/>
        <xsl:with-param name="uuid" select="did/unitid/@identifier"/>
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="dsc">
    <xsl:param name="archnr"/>
    <xsl:param name="uuid"/>
    <xsl:apply-templates select="c">
        <xsl:with-param name="archnr" select="$archnr"/>
        <xsl:with-param name="uuid" select="$uuid"/>
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="c">
    <xsl:param name="archnr"/>
    <xsl:param name="uuid"/>
    <rico:RecordSet>
        <xsl:attribute name="rdf:about">
            <xsl:value-of select="$baseUri"/>
            <xsl:value-of select="@level"/>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="did/unitid/@identifier"/>
        </xsl:attribute>
        <xsl:if test="@level='file'">
            <schema:url>
                <xsl:value-of select="$baseUrl"/>
                <xsl:text>archief/</xsl:text>
                <xsl:value-of select="$archnr"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="did/unitid"/>
            </schema:url>
        </xsl:if>
        <rico:isOrWasIncludedIn>
            <xsl:choose>
                <xsl:when test="../../@level='fonds'">        
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$baseUri"/>
                        <xsl:text>fonds/</xsl:text>
                        <xsl:value-of select="$uuid"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="$baseUri"/>
                        <xsl:value-of select="../@level"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="../did/unitid/@identifier"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </rico:isOrWasIncludedIn>
        <xsl:if test="following-sibling::c[1]">
            <rico:precedesOrPreceded>
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="$baseUri"/>
                    <xsl:value-of select="following-sibling::c[1]/@level"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="following-sibling::c[1]/did/unitid/@identifier"/>
                </xsl:attribute>
            </rico:precedesOrPreceded>
        </xsl:if>
        <xsl:call-template name="set-recordsettype">
            <xsl:with-param name="type" select="@level"/>
        </xsl:call-template>
        <xsl:apply-templates select="did">
            <xsl:with-param name="type" select="@level"/>
        </xsl:apply-templates>
    </rico:RecordSet>
    <xsl:apply-templates select="c">
        <xsl:with-param name="archnr" select="$archnr"/>
        <xsl:with-param name="uuid" select="$uuid"/>
    </xsl:apply-templates>
</xsl:template>

<!-- creating predicates and objects -->
<!-- preliminary mapping, created in my learning-by-doing way of working! -->
<xsl:template match="did">
    <xsl:param name="type"/>
    <xsl:apply-templates select="unitid"/>
    <xsl:apply-templates select="unittitle"/>
    <xsl:apply-templates select="unitdate"/>
    <xsl:apply-templates select="physdesc">
        <xsl:with-param name="uuid" select="unitid/@identifier"/>
        <xsl:with-param name="type" select="$type"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="origination"/>
    <xsl:apply-templates select="repository"/>
    <xsl:apply-templates select="abstract"/>
</xsl:template>

<xsl:template match="unitid">
    <rico:hasOrHadIdentifier>
        <rico:Identifier>
            <rico:textualValue>
                <xsl:value-of select="."/>
            </rico:textualValue>
            <rico:hasIdentifierType>
                <rico:IdentifierType>
                    <rico:hasOrHadName>
                        <rico:Name>
                            <rico:textualValue>
                                <xsl:value-of select="@label"/>
                            </rico:textualValue>
                        </rico:Name>
                    </rico:hasOrHadName>
                </rico:IdentifierType>
            </rico:hasIdentifierType>
        </rico:Identifier>
    </rico:hasOrHadIdentifier>
    <rico:hasOrHadIdentifier>
        <rico:Identifier>
            <rico:textualValue>
                <xsl:value-of select="@identifier"/>
            </rico:textualValue>
            <rico:hasIdentifierType>
                <rico:IdentifierType>
                    <rico:hasOrHadName>
                        <rico:Name>
                            <rico:textualValue>UUID</rico:textualValue>
                        </rico:Name>
                    </rico:hasOrHadName>
                </rico:IdentifierType>
            </rico:hasIdentifierType>
        </rico:Identifier>
    </rico:hasOrHadIdentifier>
</xsl:template>

<xsl:template match="unittitle">
    <rico:hasOrHadTitle>
        <rico:Title>
            <rico:textualValue>
                <xsl:value-of select="normalize-space(.)"/>
            </rico:textualValue>
        </rico:Title>
    </rico:hasOrHadTitle>
    <rdfs:label>
        <xsl:value-of select="normalize-space(.)"/>
    </rdfs:label>
</xsl:template>

<xsl:template match="unitdate">
    <rico:isAssociatedWithDate>
        <xsl:choose>
            <xsl:when test="contains(@normal,'/')">
                <rico:DateRange>
                    <rico:hasBeginningDate>
                        <rico:SingleDate>
                            <rico:normalizedDateValue>
                                <xsl:if test="string-length(substring-before(@normal,'/')) = 4">
                                    <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#gYear</xsl:attribute>
                                </xsl:if>
                                <xsl:if test="string-length(substring-before(@normal,'/')) = 10">
                                    <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
                                </xsl:if>                      
                                <xsl:value-of select="substring-before(@normal,'/')"/>
                            </rico:normalizedDateValue>
                        </rico:SingleDate>
                    </rico:hasBeginningDate>
                    <rico:hasEndDate>
                        <rico:SingleDate>
                            <rico:normalizedDateValue>
                                <xsl:if test="string-length(substring-after(@normal,'/')) = 4">
                                    <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#gYear</xsl:attribute>
                                </xsl:if>
                                <xsl:if test="string-length(substring-after(@normal,'/')) = 10">
                                    <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
                                </xsl:if>                      
                                <xsl:value-of select="substring-after(@normal,'/')"/>
                            </rico:normalizedDateValue>
                        </rico:SingleDate>
                    </rico:hasEndDate>
                    <rico:expressedDate>
                        <xsl:value-of select="."/>
                    </rico:expressedDate>
                </rico:DateRange>
            </xsl:when>
            <xsl:otherwise>
                <rico:SingleDate>
                    <rico:normalizedDateValue>
                        <xsl:if test="string-length(@normal) = 4">
                            <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#gYear</xsl:attribute>
                        </xsl:if>
                        <xsl:if test="string-length(@normal) = 10">
                            <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
                        </xsl:if>                      
                        <xsl:value-of select="@normal"/>
                    </rico:normalizedDateValue>
                    <rico:expressedDate>
                        <xsl:value-of select="."/>
                    </rico:expressedDate>
                </rico:SingleDate>
            </xsl:otherwise>
        </xsl:choose>
    </rico:isAssociatedWithDate>
</xsl:template>

<xsl:template match="physdesc">
    <xsl:param name="uuid"/>
    <xsl:param name="type"/>
    <rico:hasInstantiation>
        <rico:Instantiation>
            <xsl:attribute name="rdf:about">
                <xsl:value-of select="$baseUri"/>
                <xsl:value-of select="$type"/>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$uuid"/>
                <xsl:text>#inst-org</xsl:text>
            </xsl:attribute>
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://data.archief.amsterdam/ontology#Representatie</xsl:text>
                </xsl:attribute>              
            </rdf:type>
            <rico:hasExtent>
                <rico:InstantiationExtent>
                    <rico:textualValue>
                        <xsl:value-of select="."/>
                    </rico:textualValue>
                </rico:InstantiationExtent>
            </rico:hasExtent>
        </rico:Instantiation>
    </rico:hasInstantiation>
</xsl:template>

<xsl:template match="abstract">
    <rico:scopeAndContent>
        <xsl:attribute name="rdf:parseType">Literal</xsl:attribute>
        <xsl:copy-of select="."/>
    </rico:scopeAndContent>
</xsl:template>

<xsl:template match="origination">
    <rico:hasAccumulator>
        <xsl:choose>
            <xsl:when test="persname">
                <rico:Person>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="persname"/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:Person>
            </xsl:when>
            <xsl:when test="corpname">
                <rico:CorporateBody>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="corpname"/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:CorporateBody>
            </xsl:when>
            <xsl:when test="famname">
                <rico:Family>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="famname"/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:Family>
            </xsl:when>
            <xsl:otherwise>
                <rico:Agent>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="."/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:Agent>
            </xsl:otherwise>
        </xsl:choose>
    </rico:hasAccumulator>
</xsl:template>

<xsl:template match="repository">
    <rico:hasOrHadHolder>
        <xsl:choose>
            <xsl:when test="persname">
                <rico:Person>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="persname"/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:Person>
            </xsl:when>
            <xsl:when test="corpname">
                <rico:CorporateBody>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="corpname"/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:CorporateBody>
            </xsl:when>
            <xsl:when test="famname">
                <rico:Family>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="famname"/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:Family>
            </xsl:when>
            <xsl:otherwise>
                <rico:Agent>
                    <rico:hasOrHadAgentName>
                        <rico:AgentName>
                            <rico:textualValue>
                                <xsl:value-of select="."/>
                            </rico:textualValue>
                        </rico:AgentName>
                    </rico:hasOrHadAgentName>
                </rico:Agent>
            </xsl:otherwise>
        </xsl:choose>
    </rico:hasOrHadHolder>
</xsl:template>


<!-- named templates -->
<xsl:template name="set-recordsettype">
    <xsl:param name="type"/>
    <xsl:choose>
        <xsl:when test="$type = 'fonds'">
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://data.archief.amsterdam/ontology#Archief</xsl:text>
                </xsl:attribute>              
            </rdf:type>
            <rico:hasRecordSetType>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Fonds</xsl:text>
                </xsl:attribute>
            </rico:hasRecordSetType>
        </xsl:when>
        <xsl:when test="$type = 'collection'">
            <rico:hasRecordSetType>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Collection</xsl:text>
                </xsl:attribute>
            </rico:hasRecordSetType>
        </xsl:when>
        <xsl:when test="$type = 'series'">
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://data.archief.amsterdam/ontology#Verzameling</xsl:text>
                </xsl:attribute>              
            </rdf:type>
            <rico:hasRecordSetType>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Series</xsl:text>
                </xsl:attribute>
            </rico:hasRecordSetType>
        </xsl:when>
        <xsl:when test="$type = 'subseries'">
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://data.archief.amsterdam/ontology#Verzameling</xsl:text>
                </xsl:attribute>              
            </rdf:type>
            <rico:hasRecordSetType>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Series</xsl:text>
                </xsl:attribute>
            </rico:hasRecordSetType>
        </xsl:when>
        <xsl:when test="$type = 'otherlevel'">
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://data.archief.amsterdam/ontology#Verzameling</xsl:text>
                </xsl:attribute>              
            </rdf:type>
            <rico:hasRecordSetType>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Series</xsl:text>
                </xsl:attribute>
            </rico:hasRecordSetType>
        </xsl:when>
        <xsl:when test="$type = 'file'">
            <rdf:type>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://data.archief.amsterdam/ontology#Bestanddeel</xsl:text>
                </xsl:attribute>              
            </rdf:type>
            <rico:hasRecordSetType>
                <xsl:attribute name="rdf:resource">
                    <xsl:text>https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#File</xsl:text>
                </xsl:attribute>
            </rico:hasRecordSetType>
        </xsl:when>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
