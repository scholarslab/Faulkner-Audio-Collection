# module for containing "config"-type objects
module Solr
  mattr_accessor :solr_url
  self.solr_url = 'http://localhost:8983/solr/'
  
  # returns a solr singleton
  def self.solr
    @solr ||= (
      c = RSolr::Ext.connect(:url => Solr.solr_url)
    )
  end
  
end