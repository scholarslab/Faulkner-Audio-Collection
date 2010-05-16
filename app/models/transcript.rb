class Transcript < ActiveRecord::Base
  
  # Set up will_paginate plugin
  cattr_reader :per_page
  @@per_page = 15
  
  # We're treating the file system as the "datastore" 
  # Find overrides and returns a reference to the generated partial
  def self.find(*args) 
    
    #TODO: needs a rescue handler to return a 404 instead of an app error

    # get the file
    fname = File.basename(args.to_s)
    
    # return the file partial to be rendered in the view
    return output_name = RAILS_ROOT + "/public/tei/_" + fname + '.html.erb'
    
  end
  
  # full text searching from Solr
  def self.search(input)
    # make a shallow copy of the input params
    params = input.dup
    
    # connect to the solr server
    # the SOLR_URL constant is set it config/initializers/solr.rb
    solr = RSolr.connect :url => SOLR_URL
    
    # TODO: fix this to make it a facet query on type:transcription
    solr_params = {
        :page=>params[:page],
        :per_page=>@@per_page,
        :queries=>params[:q] + " type:transcription",
        :hl => true,
        "hl.fl" => "fulltext",
        :echoParams => 'EXPLICIT'
      }
    
    return solr.find(solr_params)
  end
  
end
