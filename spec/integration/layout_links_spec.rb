require 'spec_helper'

describe "LayoutLinks" do
  
  # main pages
  it "should have a Home page at '/'" do
    get '/'
    response.should render_template('transcripts/index')
  end
  
  # Sites
  it "should have a Browse page at '/transcripts" do
    get '/transcripts'
    response.should render_template('transcripts/index')
  end
  
  
  
end