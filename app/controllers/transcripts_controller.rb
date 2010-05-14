class TranscriptsController < ApplicationController
  
  # main display page
  def index  
    @files = Dir[RAILS_ROOT + '/db/tei/*.xml']
  end
  
  # display a single transcript
  def show
    
    # check if the file exists
    @transformed = Transcript.find(params[:file])
    
  end
  
  # perform a search
  def search
    
    @transcripts = Transcript.search(params)
    
  end
  
  protected
  
  # convert the offset param to an integer
  def current_offset
    params[:offset].to_i
  end
  
  # queries solr with a preset set of solr params
  # the :q, :f and :page params are used
  def query_solr(extra_params = {})
    
    solr.find({
      :qt => :search,
      :q => params[:q],
      :phrase_filters => params[:f],
      :per_page => self.per_page,
      :page => params[:page]
    }.merge(extra_params))
  end
  
  # calculate the per_page based on params[:per_page]
  def per_page
    v = params[:per_page].to_i
    # be reasonable
    return 10 if v < 10
    return 100 if v > 100
    v
  end
  
end
