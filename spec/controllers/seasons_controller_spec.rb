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
    @admin.stub!(:has_role?).with("admin").and_return(true)    
    @admin
  end
  
  def mock_round(stubs={})
    @mock_round = mock_model(Round, stubs)  	
  end
  
  def mock_season(options = {})
    @mock_season ||= mock_model(Season, { :name => 'test', 
                                          :rounds_count => 5, 
                                          :questions_count => 3, 
                                          :save => true, 						       
                                          :destroy => true, }.merge(options))
  end
 
  before do
  	login_as mock_admin
  	controller.stub!(:check_roles).and_return(true)	
	controller.stub!(:authorized?).and_return(true)
    @params = { "name" => 'First', "rounds_count" => 5, "questions_count" => 5}	 
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
    
    describe "responding to GET new" do
    
      def do_get
        get :new
      end
    
	  it "should expose a new season as @season" do
	    Season.should_receive(:new).and_return(mock_season(:save => false))
	    do_get		
	    assigns[:season].should equal(mock_season(:save => false))
	  end
    end
    
    describe "responding to POST create" do  
    	
	  def do_post
        post :create, :season => @params
	  end
	  
      describe "with valid params" do
      
  	    it "should expose a newly created season as @season" do      	
	      Season.should_receive(:new).with(@params).and_return(mock_season)
	      controller.should_receive(:check_roles).and_return(true)	
	      controller.should_receive(:authorized?).and_return(true)
	      do_post
	      assigns(:season).should equal(mock_season)
	    end
	
	    it "should redirect to the created season" do	      
	      Season.stub!(:new).with(@params).and_return(mock_season)
	      controller.should_receive(:check_roles).and_return(true)	
	      controller.should_receive(:authorized?).and_return(true)
	      do_post
	      response.should redirect_to(season_url(mock_season))
	    end 
	     
      end    
          
      describe "with invalid params" do
    
        it "should expose a newly created but unsaved season as @season" do      	
          Season.stub!(:new).with(@params).and_return(mock_season(:save => false))
          controller.should_receive(:check_roles).and_return(true)	
	      controller.should_receive(:authorized?).and_return(true)
          do_post
          assigns(:season).should equal(mock_season(:save => false))
        end

        it "should re-render the 'new' template" do
          Season.stub!(:new).and_return(mock_season(:save => false))
          controller.should_receive(:check_roles).and_return(true)	
	      controller.should_receive(:authorized?).and_return(true)
          do_post
          response.should render_template('new')
        end     

      end      
      
	end
	fixtures :users
  describe "responding to DELETE destroy" do
  	
  	describe "an anonymus user is signed in" do
  	end
  	
  	describe "when admin user is signed" do		
	  it "should find the season requested" do
	  	login_as mock_admin	
	    Season.should_receive(:find).with("37").and_return(mock_season)
	    delete :destroy, :id =>37
	  end

      it "should destroy the requested season" do
      	login_as mock_admin	
        Season.should_receive(:find).with("37").and_return(mock_season)        
        mock_season.should_receive(:destroy)
        delete :destroy, :id => "37"
      end
  
      it "should redirect to the seasons list" do
        login_as mock_admin	  
        Season.stub!(:find).and_return(mock_season(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(seasons_url)
      end
    end    
  end
  	
end