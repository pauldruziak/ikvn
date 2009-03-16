require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SeasonsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "seasons", :action => "index").should == "/seasons"
    end
  
    it "should map #new" do
      route_for(:controller => "seasons", :action => "new").should == "/seasons/new"
    end
  
    it "should map #show" do
      route_for(:controller => "seasons", :action => "show", :id => 1).should == "/seasons/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "seasons", :action => "destroy", :id => 1).should == "/seasons/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/seasons").should == {:controller => "seasons", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/seasons/new").should == {:controller => "seasons", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/seasons").should == {:controller => "seasons", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/seasons/1").should == {:controller => "seasons", :action => "show", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/seasons/1").should == {:controller => "seasons", :action => "destroy", :id => "1"}
    end
  end
end
