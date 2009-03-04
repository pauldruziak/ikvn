require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include AuthenticatedSystem
describe SeasonsController do
  def mock_admin
    @admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
  end
  
  def mock_round(stubs={})
    @mock_round = mock_model(Round, stubs)  	
  end
  
  def mock_season(options = {})
    @mock_season ||= mock_model(Season, { :name => 'test', :rounds_count => 5, :questions_count => 3, :save => true }.merge(options))
  end
 
  describe	"without login" do
    before do          
      @season = mock_model(Season, { :name => "First", :rounds_count => 5, :questions_count => 5})
    end 
  
    describe "responding to GET index" do
	  def do_get
	    get :index
	  end
	
      it "should expose all seasons as @seasons" do
        Season.should_receive(:find).with(:all).and_return([@season])
        do_get
        assigns[:seasons].should == [@season]
      end
    end
    
    describe "responding to GET show" do
	  def do_get
	    get :show, :id => "37"
	  end
      it "should expose the requested season as @season" do
        Season.should_receive(:find).with("37").and_return(@season)
        do_get
        assigns[:season].should == @season
      end
    end
  end
  
  
  describe "with login" do
  	before do        	  
	  login_as mock_admin
	  current_user.stub!(:has_role?).and_return(true)
	  controller.stub!(:check_roles).and_return(true)	
	  @params = { "name" => 'First', "rounds_count" => 5, "questions_count" => 5}	  
    end 
    
    describe "responding to GET new" do
    
      def do_get
        get :new
      end
    
      it "should login required" do
        do_get
        current_user.should_not be_nil
      end
    
      it "should role 'admin' required" do
        do_get
        current_user.has_role?("admin").should be_true
      end
    
	  it "should expose a new season as @season" do
	    Season.should_receive(:new).and_return(mock_season(:save => false))
	    get :new		
	    assigns[:season].should equal(mock_season(:save => false))
	  end
    end
    
    describe "responding to POST create" do  
    	
	  def do_post
        post :create, :season => @params
	  end
	  
      describe "with valid params" do
      
      	it "should login required" do
          do_post
          current_user.should_not be_nil
        end
    
        it "should role 'admin' required" do
          do_post
          current_user.has_role?("admin").should be_true
        end
  
  	    it "should expose a newly created season as @season" do      	
	      Season.should_receive(:new).with(@params).and_return(mock_season)
	      do_post
	      assigns(:season).should equal(mock_season)
	    end
	
	    it "should redirect to the created season" do	      
	      Season.stub!(:new).with(@params).and_return(mock_season)
	      do_post
	      response.should redirect_to(season_url(mock_season))
	    end 
	     
      end    
          
      describe "with invalid params" do
    
        it "should expose a newly created but unsaved season as @season" do      	
          Season.stub!(:new).with(@params).and_return(mock_season(:save => false))
          do_post
          assigns(:season).should equal(mock_season(:save => false))
        end

        it "should re-render the 'new' template" do
          Season.stub!(:new).and_return(mock_season(:save => false))
          do_post
          response.should render_template('new')
        end     

      end      
      
	end
	
	describe "responding to DELETE destroy" do

      it "should destroy the requested season" do
        Season.should_receive(:find).with("37").and_return(mock_season)
        mock_season.should_receive(:destroy)
        delete :destroy, :id => "37"
      end
  
      it "should redirect to the seasons list" do
        Season.stub!(:find).and_return(mock_season(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(seasons_url)
      end

    end
	    
  end
  	
end