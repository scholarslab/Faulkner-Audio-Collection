require 'spec_helper'

describe "/transcripts/show/" do
  before(:each) do
    render '/transcripts/show'
  end

  it "should have a the collection in a header" do
    response.should have_tag('h1', %r[William Faulkner Audio Collection])
  end
  
  it "should have a table of contents" do
    response.should have_tag('h2', %r[Table of Contents])
  end
  
  it "should have a quicktime player" do
    
  end
end