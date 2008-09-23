require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pitches/index.html.haml" do
  include PitchesHelper
  
  before(:each) do
    assigns[:pitches] = [mock_model(Pitch), mock_model(Pitch)]
  end

  it "should render list of pitches" do
    render "/pitches/index.html.haml"
  end
end
