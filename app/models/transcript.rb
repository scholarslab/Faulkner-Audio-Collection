class Transcript < ActiveRecord::Base
  
  # Set up will_paginate plugin
  cattr_reader :per_page
  @@per_page = 15
  #TODO: This shoudl be set in an initializer or environment.rb
  SOLR_URL = "http://staging.faulkner.lib.virginia.edu:8080/solr/faulkner"
  
  # We're treating the file system as the "datastore" 
  # Find overrides and returns a reference to the generated partial
  def self.find(*args) 

    # get the file
    fname = File.basename(args.to_s)
    
    #return the file partial to be rendered in the view
    return output_name = RAILS_ROOT + "/public/tei/_" + fname.gsub('.xml', '.html.erb')
    
  end
  
  # full text searching from Solr
  def self.search(input)
    # make a shallow copy of the input params
    params = input.dup
    
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
