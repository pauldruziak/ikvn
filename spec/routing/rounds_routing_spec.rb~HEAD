require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoundsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "rounds", :action => "index", :season_id => "1").should == "/seasons/1/rounds"
    end
  
    it "should map #show" do
      route_for(:controller => "rounds", :action => "show", :season_id => "1", :id => "1").should == "/seasons/1/rounds/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "rounds", :action => "edit", :season_id => "1", :id => "1").should == "/seasons/1/rounds/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "rounds", :action => "update", :season_id => "1", :id => "1").should == "/seasons/1/rounds/1"
    end
    
    it "should map #publish" do
      route_for(:controller => "rounds", :action => "publish", :season_id => "1", :id => "1").should == "/seasons/1/rounds/1/publish"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/seasons/1/rounds").should == {:controller => "rounds", :action => "index", :season_id => "1"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/seasons/1/rounds/1").should == {:controller => "rounds", :action => "show", :season_id => "1", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/seasons/1/rounds/1/edit").should == {:controller => "rounds", :action => "edit", :season_id => "1", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/seasons/1/rounds/1").should == {:controller => "rounds", :action => "update", :season_id => "1", :id => "1"}
    end
    
    it "should generate params for #publish" do
      params_from(:get, "/seasons/1/rounds/1/publish").should == {:controller => "rounds", :action => "publish", :season_id => "1", :id => "1"}
    end
  end
end
