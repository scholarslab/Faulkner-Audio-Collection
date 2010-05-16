class TranscriptsController < ApplicationController
  
  # main display page
  def index  
    # Navigation partial is generated with 'rake render:gen_navigation'
    
    #@files = Dir[RAILS_ROOT + '/db/tei/*.xml']
  end
  
  # display a single transcript
  # The xml response returns the original TEI document
  def show
    
    # check if the file exists
    @transformed = Transcript.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml {render :file => "#{RAILS_ROOT}/db/tei/#{params[:id]}.xml"}
    end
    
  end
  
  # perform a search using Solr by overriding the ActiveRecord search
  def search
    
    @transcripts = Transcript.search(params)
    
  end
  
  
end
