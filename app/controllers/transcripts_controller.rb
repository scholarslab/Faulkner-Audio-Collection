class TranscriptsController < ApplicationController
  
  # main display page
  def index  
    #@files = Dir[RAILS_ROOT + '/db/tei/*.xml']
  end
  
  # display a single transcript
  def show
    
    # check if the file exists
    @transformed = Transcript.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml {render :file => "#{RAILS_ROOT}/db/tei/#{params[:id]}.xml"}
    end
    
  end
  
  # perform a search
  def search
    
    @transcripts = Transcript.search(params)
    
  end
  
  
end
