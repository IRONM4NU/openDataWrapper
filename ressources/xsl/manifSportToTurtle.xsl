<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ex="http://www.example.org/" 
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:foaf="http://xmlns.com/foaf/0.1/"
	> 
<xsl:output method='text' encoding='UTF-8'/>

<xsl:template match="document">
	<xsl:apply-templates select="data"/>
</xsl:template>

<xsl:variable name="incr" select="0"></xsl:variable>

<xsl:template match="data">
	<xsl:text>
@prefix dbpedia: &lt;http://dbpedia.org/resource/&gt; .
@prefix prop-fr: &lt;http://fr.dbpedia.org/property/&gt; .
@prefix foaf: &lt;http://xmlns.com/foaf/0.1/&gt; .
@prefix ex: &lt;http://example.org/&gt; .
@prefix owl: &lt;http://www.w3.org/2002/07/owl#&gt; .
@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix dbpprop: &lt;http://dbpedia.org/property/&gt; .
@prefix dbpedia-owl: &lt;http://dbpedia.org/ontology/&gt; .
@prefix sc: &lt;http://schema.org/&gt; .
@prefix geo: &lt;http://www.w3.org/2003/01/geo/wgs84_pos#&gt; .

</xsl:text>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="element">
	<xsl:apply-templates select="MANIFESTATION"/>
	<xsl:apply-templates select="COMMUNE_CODE_INSEE"/>
	<xsl:apply-templates select="DATE_FIN"/>
	<xsl:apply-templates select="COMMUNE"/>
	<xsl:apply-templates select="DATE_DEBUT"/>
	<xsl:apply-templates select="DEPARTEMENT"/>
	<xsl:apply-templates select="DISCIPLINE"/>
	<xsl:apply-templates select="TYPE"/>

</xsl:template>

<xsl:template match="COMMUNE_CODE_INSEE">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:insee&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:insee&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="DATE_FIN">
<xsl:choose><xsl:when test=". = 'null'">&#009;sc:endDate&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;sc:endDate&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="COMMUNE">
<xsl:choose><xsl:when test=". = 'null'">&#009;dbpprop:town&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;dbpprop:town&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="DATE_DEBUT">
<xsl:choose><xsl:when test=". = 'null'">&#009;sc:startDate&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;sc:startDate&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="MANIFESTATION"><xsl:choose><xsl:when test=". = 'null'"></xsl:when>
<xsl:otherwise><xsl:value-of select="concat(concat('&lt;http://projet.com/10/',translate(translate(translate(translate(translate(translate(./text(),'&quot;',' '),'&gt;',' '),'&lt;',' '),'  ',' '),' ','_'),'.','_')),'&gt;')"/>&#009; foaf:name &#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="DEPARTEMENT">
<xsl:choose><xsl:when test=". = 'null'">&#009;dbpedia-owl:department&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;dbpedia-owl:department&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="DISCIPLINE">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:discipline&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:discipline&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="TYPE">
<xsl:choose><xsl:when test=". = 'null'">&#009;rdf:type&#009; "undefined"^^xsd:string .

</xsl:when>
<xsl:otherwise>&#009;rdf:type&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string .

</xsl:otherwise></xsl:choose></xsl:template>

</xsl:stylesheet>