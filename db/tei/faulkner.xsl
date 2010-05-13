<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd" version="1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="no" media-type="text/html" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 12, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Wayne Graham</xd:p>
            <xd:p>Stylesheet for the Faulkner at Virginia Project</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        
        <div id="side_nav">
            <ul>
                <xsl:for-each select="//div2">
                    <li><a href="#{@id}"><xsl:value-of select="head" /></a></li>
                </xsl:for-each>
            </ul>
        </div>
        
        <xsl:for-each select="//div2">
            <div class="section">
                 <a name="{@id}"></a>
                 <p>
                     <xsl:value-of select="u"/>
                 </p>
            </div>
        </xsl:for-each>
     
        
    </xsl:template>
    
</xsl:stylesheet>
