require 'rubygems'
require 'nokogiri'

namespace :render do
  
  # Where the TEI partials will be stored
  TRANSFORM_BASE = RAILS_ROOT + "/public/tei"
  
  desc 'Pre-render XML files for speed'
  task :pre_render do
    
    # set the xslt file
    xslt = Nokogiri::XSLT(File.read(RAILS_ROOT + "/db/tei/faulkner.xsl"))
    
    # iterate over each file in the /db/tei directory
    Dir[RAILS_ROOT + "/db/tei/*.xml"].each do |file|
      
      # create a File object from the string to pull it's file name
      fname = File.basename(file)
      
      # create a filename using the partial naming convention for the file
      output_name = "_" + fname.gsub('.xml', '.html.erb')
      
      # read the xml file and transform the document
      xml = Nokogiri::XML(File.read(file))
      transformed = xslt.transform(xml)
      
      # write the file
      File.open("#{TRANSFORM_BASE}/#{output_name}", 'w'){ |f| f.write(transformed) }
      
    end 
  end
  
  desc 'Generate the generalized navigation partial for TEI database'
  task :gen_navigation do
    
    # set the xslt file
    xslt = Nokogiri::XSLT(File.read(RAILS_ROOT + "/db/tei/navigation.xsl"))
    
    # set the path to the navgiation partial
    nav_partial = RAILS_ROOT + "/app/views/transcripts/_navigation.html.erb"
    
    # Delete the transcripts navigation partials if it exists.
    File.delete(nav_partial) if File.exists?(nav_partial)
    
    # The approach here is to read the header in each file and then append it to a
    # navigation partial
    Dir[RAILS_ROOT + "/db/tei/*.xml"].each do |file|
      
      # read and transform the xml files in /db/tei
      xml = Nokogiri::XML(File.read(file))
      transformed = xslt.transform(xml)
      
      # Append the output to the app/views/transcripts/_navigation.html.erb partial
      File.open(nav_partial, 'a'){ |f| f.write(transformed) } 
    end
  end
  
end