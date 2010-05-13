class TranscriptsController < ApplicationController
  
  XSLT_PATH = File.join(RAILS_ROOT, 'db', 'tei', 'faulkner.xsl')
  
  def index  
    @files = Dir.glob(RAILS_ROOT + '/db/tei/*.xml')
  end
  
  def show
    xml_path = File.join(RAILS_ROOT, 'db', 'tei', 'wfaudio01_1.xml')

    @xml = Nokogiri::XML(File.read(xml_path))
    @xslt = Nokogiri::XSLT(File.read(XSLT_PATH))

    @transformed = @xslt.transform(@xml)
  end
end
