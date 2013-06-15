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
	<xsl:apply-templates select="geo/name"/>
	<xsl:apply-templates select="_l"/>
	<xsl:apply-templates select="LIBTHEME"/>
	<xsl:apply-templates select="CODE_POSTAL"/>
	<xsl:apply-templates select="WEB"/>
	<xsl:apply-templates select="STATUT"/>
	<xsl:apply-templates select="TELEPHONE"/>
	<xsl:apply-templates select="THEME"/>
	<xsl:apply-templates select="COMMUNE"/>
	<xsl:apply-templates select="LIBCATEGORIE"/>
	<xsl:apply-templates select="ADRESSE"/>
	<xsl:apply-templates select="LIBTYPE"/>
	<xsl:apply-templates select="_IDOBJ"/>
	<xsl:apply-templates select="TYPE"/>
	<xsl:apply-templates select="CATEGORIE"/>

</xsl:template>

<xsl:template match="_l"><xsl:choose><xsl:when test=". = 'null'">&#009;ex:coordinate&#009; "NaN"^^xsd:decimal ;
</xsl:when>
<xsl:otherwise>&#009;ex:coordinate&#009; "<xsl:value-of select="."/>"^^xsd:decimal ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="LIBTHEME">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:libTheme&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:libTheme&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="CODE_POSTAL">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:cp&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:cp&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="WEB">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:siteWeb&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:siteWeb&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="STATUT">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:statut&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:statut&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="TELEPHONE">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:tel&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:tel&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="THEME">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:theme&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:theme&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="COMMUNE">
<xsl:choose><xsl:when test=". = 'null'">&#009;dbpprop:town&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;dbpprop:town&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="geo/name"><xsl:choose><xsl:when test=". = 'null'"></xsl:when>
<xsl:otherwise><xsl:value-of select="concat(concat('&lt;http://projet.com/10/',translate(translate(translate(translate(translate(translate(./text(),'&quot;',' '),'&gt;',' '),'&lt;',' '),'  ',' '),' ','_'),'.','_')),'&gt;')"/>&#009; foaf:name &#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="LIBCATEGORIE">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:libCat&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:libCat&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="ADRESSE">
<xsl:choose><xsl:when test=". = 'null'">&#009;dbpprop:location&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;dbpprop:location&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="LIBTYPE">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:libType&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:libType&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="_IDOBJ">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:id&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;ex:id&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="TYPE">
<xsl:choose><xsl:when test=". = 'null'">&#009;rdf:type&#009; "undefined"^^xsd:string ;
</xsl:when>
<xsl:otherwise>&#009;rdf:type&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string ;
</xsl:otherwise></xsl:choose></xsl:template>

<xsl:template match="CATEGORIE">
<xsl:choose><xsl:when test=". = 'null'">&#009;ex:categorie&#009; "undefined"^^xsd:string .

</xsl:when>
<xsl:otherwise>&#009;ex:categorie&#009; "<xsl:value-of select="translate(., '&quot;','')"/>"^^xsd:string .

</xsl:otherwise></xsl:choose></xsl:template>

</xsl:stylesheet>