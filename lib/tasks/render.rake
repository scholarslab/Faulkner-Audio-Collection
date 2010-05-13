require 'rubygems'
require 'nokogiri'

namespace :render do
  
  TRANSFORM_BASE = RAILS_ROOT + "/public/tei"
  
  desc 'Pre-render XML files for speed'
  task :pre_render do
    
    # set the xslt file
    xslt = Nokogiri::XSLT(File.read(RAILS_ROOT + "/db/tei/faulkner.xsl"))
    
    Dir[RAILS_ROOT + "/db/tei/*.xml"].each do |file|
      
      # create a File object from the string
      fname = File.basename(file)
      
      output_name = "_" + fname.gsub('.xml', '.html.erb')
      
      # read the xml file
      xml = Nokogiri::XML(File.read(file))
      
      # do the transform
      transformed = xslt.transform(xml)
      
      # write the files
      File.open("#{TRANSFORM_BASE}/#{output_name}", 'w'){ |f| f.write(transformed) }
      
    end
     
  end
  
  desc 'Generate the generalized navigation for TEI database'
  task :gen_navigation do
    
    # set the xslt dir
    xslt = Nokogiri::XSLT(File.read(RAILS_ROOT + "/db/tei/navigation.xsl"))
    
    nav_partial = RAILS_ROOT + "/app/views/transcripts/_navigation.html.erb"
    
    # TODO: clobber the navigation erb
    File.delete(nav_partial) if File.exists?(nav_partial)
    
    # The approach here is to read the header file in each file and then add it to a
    # navigation partial
    Dir[RAILS_ROOT + "/db/tei/*.xml"].each do |file|
      
      output_name = "_navigation.html.erb"
     
      # read and transform the xml file
      xml = Nokogiri::XML(File.read(file))
      transformed = xslt.transform(xml)
      
      # Write to the app/views/transcripts directory
      File.open(nav_partial, 'a'){ |f| f.write(transformed) } 
    end
    
    
  end
  
end