class Transcript < ActiveRecord::Base
  
  # Set up will_paginate plugin
  cattr_reader :per_page
  @@per_page = 15
  
  # We're treating the file system as the "datastore" 
  # Find overrides and returns a reference to the generated partial
  def self.find(*args) 

    # get the file
    fname = File.basename(args.to_s)
    
    #return the 
    return output_name = RAILS_ROOT + "/public/tei/_" + fname.gsub('.xml', '.html.erb')
    
  end
  
  # Full text searching from Solr
  def self.search(input)
    # make a shallow copy of the input
    params = input.dup
    
    find_params = {}
    find_params[:page] = params[:page]
    
    #http://staging.faulkner.lib.virginia.edu:8080/solr/faulkner/select?&q=fury+type%3Atranscription
    
    self.paginate(find_params)
    
  end
  
end
