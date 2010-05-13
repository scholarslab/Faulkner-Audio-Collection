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
  
end