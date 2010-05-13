class Transcript < ActiveRecord::Base
  
  # We're treating the file system as the "datastore" 
  # Find overrides and returns a reference to the generated partial
  def self.find(*args) 
    # get the file
    fname = File.basename(args.to_s)
    
    #return the 
    return output_name = RAILS_ROOT + "/public/tei/_" + fname.gsub('.xml', '.html.erb')
    
  end
  
end
