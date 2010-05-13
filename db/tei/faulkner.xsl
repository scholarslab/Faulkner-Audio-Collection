<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd tei" version="1.0">
    
  <xsl:output method="text" />
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 12, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Wayne Graham</xd:p>
            <xd:p>Stylesheet for the Faulkner at Virginia Project</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        
        <xsl:apply-templates select="TEI.2/text/body"/>
        
    </xsl:template>
    
    <xsl:template match="div1">
        
        <xsl:call-template name="toc" />
        
        <div id="header">
            <xsl:for-each select="head">
                <h3><xsl:value-of select="."/></h3>
            </xsl:for-each>
        </div>
        
		<div id="body">
        	<xsl:apply-templates select="div2"/>
        </div>
    </xsl:template>

	<xsl:template match="div2">
		<a name="{@id}"></a>
	    <xsl:apply-templates select="u" />
	</xsl:template>
	
	<xsl:template match="u">
	    <!-- don't use this for realz -->
	    <xsl:variable name="speakers" select="/TEI.2/teiHeader/profileDesc/particDesc" />
	    <xsl:variable name="who" select="@who" />
	    
	    <p><strong><xsl:value-of select="//*[@id = $who]" />:</strong> <xsl:apply-templates /></p>
		<hr/>
	</xsl:template>

    <xsl:template name="toc">
		<div id="side_nav">
            <ul>
                <xsl:for-each select="//div2">
                    <li><a href="#{@id}"><xsl:value-of select="head" /></a></li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    
    <xsl:template match="unclear">
        <span class="unclear tooltip" title="Text was unclear">[<xsl:apply-templates/>]</span>
    </xsl:template>
    
    <xsl:template match="gap">
        <span class="gap tooltip" title="There was a gap in the tape">[gap in tape]</span>
    </xsl:template>
    
    <xsl:template match="event">
        <span class="event tooltip" title="There was some {@desc} happening">[<xsl:value-of select="@desc" />]</span>
    </xsl:template>
    
    <xsl:template match="hi">
        <xsl:if test="@rend='italic'">
            <em><xsl:apply-templates /></em>
        </xsl:if>
        
    </xsl:template>
</xsl:stylesheet>
