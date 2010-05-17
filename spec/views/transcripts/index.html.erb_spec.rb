require 'spec_helper'

describe "/transcripts/" do
  before(:each) do
    render '/transcripts/index'
  end
  
  it "should have a the collection in a header" do
    response.should have_tag('h1', %r[William Faulkner Audio Collection])
  end
  
  it "should have a title in a dd" do
    response.should have_tag('dd', %r[Gwynn's American Fiction Class])
  end
  
  it "should have a date in an an anchor tag" do
    response.should have_tag('a', %r[15 February 1957])
  end
  
end