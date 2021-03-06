<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:str="http://exslt.org/strings"
	extension-element-prefixes="str"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd tei str" version="1.0">
    
    <xsl:output method="html" indent="yes" />
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 12, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> Wayne Graham</xd:p>
            <xd:p>Stylesheet for the Faulkner at Virginia Project</xd:p>
        </xd:desc>
    </xd:doc>
	
	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Grab the body of the TEI to parse for partial</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="/">
        <xsl:apply-templates select="TEI.2/text/body"/>
    </xsl:template>
    
    <xd:doc scope="component">
        <xd:desc>
            <xd:p>Match <xd:b>div1</xd:b> field</xd:p>
        	<xd:p>Parses the file name for the file; writes the QTP for the file</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="div1">
        
        <xsl:variable name="filename" select="//idno[@type='digital audio filename']"/>

    	<script language="JavaScript" type="text/javascript">
			$(document).ready(function(){
				$("#<xsl:value-of select="@type" />").qtp("<xsl:value-of select="str:replace($filename, 'read', '')" />.mp4");
				<!-- TODO: Load the rest of the files when the DOM loads -->
			<!-- <xsl:for-each select="div2">
							$("#<xsl:value-of select="@id"/>-player").qtp("<xsl:value-of select="$filename"/>.mp4", "<xsl:value-of select="@start"/>:00", "<xsl:value-of select="@end"/>:00");
						</xsl:for-each> -->
			});
		</script>
  
        <section id="main-content" class="span-16">
        	<header class="collection-title">
        		<hgroup>
        			<h1><a href="/">William Faulkner Audio Collection</a></h1>
        			<h3>Transcript</h3>
            		<xsl:for-each select="head">
                		<h4><xsl:value-of select="."/></h4>
            		</xsl:for-each>
          		</hgroup>
        			<div class="audio play-all" id="{@type}">
        				Play entire recording
        			</div>
        	</header>
        
			<div id="transcript-body">
        		<xsl:apply-templates select="div2"/>
			</div>
        </section>
    	<!-- Generate the table of contents -->
    	<xsl:call-template name="toc" />
    	
    </xsl:template>
	
	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Each div2 is a "section" of the file; generate a QTP (replacing 'read' in the file name)</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="div2">
		<div class="utterance">
	    <xsl:variable name="filename" select="//idno[@type='digital audio filename']"/>
	    
			<div class="audio play-clip" id="{@id}">
			Play section
	    	<script type="text/javascript">
				try {
					QT_WriteOBJECT(
					'http://qss.itc.virginia.edu/medialab/faulkner_audio/<xsl:value-of select="str:replace($filename, 'read', '')"/>.mp4', '610', ' 16', '',
					'autoplay', 'false',
					'scale', 'tofit',
					'starttime','<xsl:value-of select="@start"/>:00',
					'endtime','<xsl:value-of select="@end"/>:00');
				}
				catch (e) {
					//document.write(e);
				}
	    	</script> 
	    </div>
	    <xsl:apply-templates select="u" />
			</div>
	    <hr/>
	</xsl:template>
	
	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Format the utterance</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template match="u">
		<!-- get the list of users listed in the document -->
	    <xsl:variable name="speakers" select="/TEI.2/teiHeader/profileDesc/particDesc" />
		<!-- get who's speaking in the utterance -->
	    <xsl:variable name="who" select="@who" />
	    
	    <p>
	    	<span class="speaker"><xsl:value-of select="//*[@id = $who]" /></span>
	        <xsl:apply-templates />
	    </p>
	</xsl:template>

	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Format the Table of contents</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:template name="toc">
		<aside class="span-6 last" id="sidebar">
			<div id="search-box">	
				<form method="get" action="/transcripts/search">
					<input type="text" size="30" name="q" id="q_text" class="search-text span-4"/>
					<input type="submit" value="search" name="submit" id="submit" class="search-form-submit"/>
				</form>
			</div>
				
			<div class="subnav"><a href="/">&#8606; Return to the Collection</a></div>

			<h3>Table of Contents</h3>
		
			<ul>
              <xsl:for-each select="//div2">
                <li><a href="#{@id}" class="hidden"><xsl:value-of select="head" /></a></li>
              </xsl:for-each>
        	</ul>
		</aside>
			
    </xsl:template>
	
	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Format the unclear elements</xd:p>
		</xd:desc>
	</xd:doc>
    <xsl:template match="unclear">
        <span class="unclear tooltip" title="Text was unclear">[<xsl:apply-templates/>]</span>
    </xsl:template>
	
	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Format the gap elements</xd:p>
		</xd:desc>
	</xd:doc>
    <xsl:template match="gap">
        <span class="gap tooltip" title="There was a gap in the tape">[gap in tape]</span>
    </xsl:template>
    
	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Format the event elements</xd:p>
		</xd:desc>
	</xd:doc>
    <xsl:template match="event">
        <span class="event tooltip" title="There was some {@desc} happening">[<xsl:value-of select="@desc" />]</span>
    </xsl:template>
    
	<xd:doc scope="component">
		<xd:desc>
			<xd:p>Format the highlight elements</xd:p>
		</xd:desc>
	</xd:doc>
    <xsl:template match="hi">
        <xsl:if test="@rend='italic'">
            <em><xsl:apply-templates /></em>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
