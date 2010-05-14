<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd tei" version="1.0">
    
    <xsl:output method="html" />
    
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
    
    <xd:doc>
        <xd:desc>
            <xd:p>Match <xd:b>div1</xd:b> field</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="div1">
        
        <xsl:variable name="filename" select="//idno[@type='digital audio filename']"/>
        
        <xsl:call-template name="toc" />
        
        <div id="header">
            <xsl:for-each select="head">
                <h3><xsl:value-of select="."/></h3>
            </xsl:for-each>
            
            <script language="JavaScript" type="text/javascript">
			try {
				QT_WriteOBJECT(
				'http://qss.itc.virginia.edu/medialab/faulkner_audio/<xsl:value-of select="$filename"/>.mp4', '300', ' 16', '',
				'autoplay', 'false',
				'scale', 'tofit');
		      }
		      catch (e) {
			     //document.write(e);
			  }</script>
            <hr/>
            
        </div>
        
		<div id="body">
        	<xsl:apply-templates select="div2"/>
        </div>
    </xsl:template>

	<xsl:template match="div2">
	    <xsl:variable name="filename" select="//idno[@type='digital audio filename']"/>
	    
		<a name="{@id}">&#160;</a>
	    <script language="JavaScript" type="text/javascript">
			try {
				QT_WriteOBJECT(
				'http://qss.itc.virginia.edu/medialab/faulkner_audio/<xsl:value-of select="$filename"/>.mp4', '300', ' 16', '',
				'autoplay', 'false',
				'scale', 'tofit',
				'starttime','<xsl:value-of select="@start"/>:00',
				'endtime','<xsl:value-of select="@end"/>:00');
		}
		catch (e) {
			//document.write(e);
		}</script>
	    
	    <!-- AddThis Button BEGIN -->
	    
	    <xsl:apply-templates select="u" />
	    <hr/>
	</xsl:template>
	
	<xsl:template match="u">
	    <!-- don't use this for realz -->
	    <xsl:variable name="speakers" select="/TEI.2/teiHeader/profileDesc/particDesc" />
	    <xsl:variable name="who" select="@who" />
	    
			<div class="speaker"><xsl:value-of select="//*[@id = $who]" /></div> 
	    <p>
	        <xsl:apply-templates />
	    </p>
	</xsl:template>

    <xsl:template name="toc">
		<div id="side_nav">
            <ul>
                <xsl:for-each select="//div2">
                    <li><a href="#{@id}" class="hidden"><xsl:value-of select="head" /></a></li>
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
