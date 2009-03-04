require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/seasons/new.html.erb" do
  include SeasonsHelper
  
  before(:each) do
    assigns[:season] = stub_model(Season,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "should render new form" do
    render "/seasons/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", seasons_path) do
      with_tag("input#season_name[name=?]", "season[name]")
      with_tag("input#season_round_count[name=?]", "season[round_count]")
      with_tag("input#season_question_count[name=?]", "season[question_count]")
    end
  end
end


