require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestionsController do
  describe "route generation" do
    it "should map #show" do
      route_for(:controller => "questions", :action => "show", :season_id => "1", :round_id => "1", :id => "1").should == "/seasons/1/rounds/1/questions/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "questions", :action => "edit", :season_id => "1", :round_id => "1", :id => "1").should == "/seasons/1/rounds/1/questions/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "questions", :action => "update", :season_id => "1", :round_id => "1", :id => "1").should == "/seasons/1/rounds/1/questions/1"
    end    
  end

  describe "route recognition" do
    it "should generate params for #show" do
      params_from(:get, "/seasons/1/rounds/1/questions/1").should == {:controller => "questions", :action => "show", :season_id => "1", :round_id => "1", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/seasons/1/rounds/1/questions/1/edit").should == {:controller => "questions", :action => "edit", :season_id => "1", :round_id => "1", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/seasons/1/rounds/1/questions/1").should == {:controller => "questions", :action => "update", :season_id => "1", :round_id => "1", :id => "1"}
    end
  end
end
