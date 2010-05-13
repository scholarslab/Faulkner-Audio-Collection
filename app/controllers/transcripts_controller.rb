class TranscriptsController < ApplicationController
  
  XSLT_PATH = File.join(RAILS_ROOT, 'db', 'tei', 'faulkner.xsl')
  
  def index  
    #TODO: figure out what to do with the browse
    @files = Dir[RAILS_ROOT + '/db/tei/*.xml']
  end
  
  def show
    
    # check if the file exists
    @transformed = Transcript.find(params[:file])
    
  end
end
