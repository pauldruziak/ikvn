require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include AuthenticatedSystem
describe SeasonsController do
  def mock_admin
    admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
    admin
  end
  
  def mock_round(stubs={})
    @mock_round = mock_model(Round, stubs)  	
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
	  @admin = mock_admin         
	  login_as @admin
	  current_user.stub!(:has_role?).and_return(true)
	  controller.stub!(:check_roles).and_return(true)	
	  @params = { "name" => "First", "rounds_count" => 5, "questions_count" => 5}	  
    end 
    
    describe "responding to GET new" do
      before(:each) do
        @season = mock_model(Season, { :name => "First", :rounds_count => 5, :questions_count => 5, :save => false})
      end
    
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
	    Season.should_receive(:new).and_return(@season)
	    get :new		
	    assigns[:season].should equal(@season)
	  end
    end
    
    describe "responding to POST create" do      
    	
      before(:each) do
      	@round = mock_model(Round, {:name => "Round"})      
      	
        @season = mock_model(Season, { :name => "First", :rounds_count => 5, :questions_count => 5, :rounds => [], :save => true})        
        @season.rounds.stub!(:build).and_return(mock_round(:name => 1), mock_round(:name => 2), mock_round(:name => 3), mock_round(:name => 4), mock_round(:name => 5)) do |arg|
        	@season.rounds << mock_round(arg)
        end        
      end  	
      
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
	      Season.should_receive(:new).with(@params).and_return(@season)
	      do_post
	      assigns(:season).should equal(@season)
	    end
	
	    it "should redirect to the created season" do	      
	      Season.stub!(:new).with(@params).and_return(@season)
	      do_post
	      response.should redirect_to(season_url(@season))
	    end
	    
	    it "should create rounds" do	    	
    	  Season.stub!(:new).with(@params).and_return(@season)	 
    	  @season.rounds.should_receive(:build).exactly(5).times     
		  do_post	      
	      @season.rounds.count.should eql(5)	      
	    end
	    
	    it "should create rounds with name" do
	      Season.stub!(:new).with(@params).and_return(@season)	      
	      do_post	      
	      5.times do |index|
	      	@season.rounds[index].name.should eql(index + 1)
	      end
	    end
	    
	    it "should first round have name '1'" do
	      Season.stub!(:new).with(@params).and_return(@season)	      
	      do_post	      	      
	      @season.rounds[0].name.should eql(1)	      
	    end
	    
	    it "should create questions" do
	      #Question.should_receive(:new).exactly(25).times
	      #do_post
	    end  
      end
    end
  end	
end