<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd tei" version="1.0">

	<xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 12, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Wayne Graham</xd:p>
            <xd:p>Stylesheet for generating navigational items</xd:p>
        </xd:desc>
    </xd:doc>

	<xsl:output method="text" />

	<xsl:template match="/">
		
		<xsl:variable name="filename"><xsl:value-of select="TEI.2[@id]" /></xsl:variable>
		
       	<dl>
			<dt>
				<a href="{filename}"><xsl:value-of select="TEI.2/teiHeader/profileDesc/settingDesc/setting/date" /></a>
			</dt>
			<dd><xsl:value-of select="TEI.2/teiHeader/profileDesc/settingDesc/setting/locale" /></dd>
		</dl>

    </xsl:template>

</xsl>