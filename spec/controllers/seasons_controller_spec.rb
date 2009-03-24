require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SeasonsController do
  def mock_admin
  	stubs = {
  	  :id => 1,
      :login  => 'user_name',
      :name   => 'U. Surname',
      :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
      :errors => [], 
      :roles  => [stub("role", {:name => "admin", :save => true})]
  	}
    @admin ||= stub("user", stubs)  
    @admin.stubs(:has_role?).with("admin").returns(true)    
    @admin
  end
  
  def mock_round(stubs={})
  	stubs = {
  	}.merge(stusb)
    @mock_round = stub("round", stubs)  	
  end
  
  def mock_season(stubs = {})
  	stubs = {
  	  :name => 'test', 
      :rounds_count => 5, 
      :questions_count => 3, 
      :rounds => [],
      :save => true, 						       
      :destroy => true
  	}.merge(stubs)
    @mock_season ||= stub("season", stubs)
    @mock_season.rounds.stubs(:published).returns([])
    @mock_season
  end
 
  before do
    @params = { "name" => 'First', "rounds_count" => 5, "questions_count" => 5, :id => '1'}	 
  end
  
  describe "before filter" do
  	
    it "should have check_round" do
      controller.before_filters.should include(:check_round)
    end 
    
    describe "check_round" do
    	
      it "should have options" do
        controller.before_filter(:check_round).should have_options(:only => [:edit, :update, :destroy])
      end
    
      it "should check a round for publishing" do
        Season.expects(:find).with(@params[:id]).returns(mock_season)
        mock_season.rounds.expects(:published).at_least(1).returns([])
        #mock_season.rounds.published.expects(:empty?).at_least(1).returns(true)
        controller.run_filter(:check_round, @params)
      end
      
      describe "when round published" do
      	
      	def do_get
      	  get :edit, @params
      	end
      
        before(:each) do
	      Season.stubs(:find).returns(mock_season)          
	      mock_season.rounds.stubs(:published).at_least(1).returns(Array.new(2, stub("round")))
          #mock_season.rounds.published.expects(:empty?).returns(false)
	    end
	
	  	it "should have flash" do	  	  
	  	  do_get
	  	  flash[:error].should_not be_nil
	  	end
	  	
	  	it "should redirect to show round" do
	  	  do_get
	  	  response.should redirect_to(season_path(mock_season))
	  	end
	  	
	  	it "should assign the found Round for the view" do	      
	      do_get
	      assigns[:season].should equal(mock_season)
	    end
	    
	  end
      
    end   
    
  end
  
  describe "responding to GET show season" do
	def do_get
	  get :show, @params
	end
	
	it "should succeed" do     
	  Season.stubs(:find)
      do_get
      response.should be_success
    end

    it "should render the 'show' template" do      
      Season.stubs(:find)
      do_get 
      response.should render_template('show')
    end    
    
    it "should find the requested round" do         
      Season.expects(:find).with(@params[:id])      
      do_get 
    end

    it "should assign the found round for the view" do     
      Season.expects(:find).returns(mock_season)
      do_get
      assigns[:season].should equal(mock_season)      
    end
    
  end

  describe "responding to GET edit season" do
  	
  	def do_get
  	  get :edit, @params
  	end  	
  	
    it "should succeed" do
      Season.stubs(:find).returns(mock_season)
      do_get 
      response.should be_success
    end

    it "should render the 'edit' template" do
      Season.stubs(:find).returns(mock_season)
      do_get
      response.should render_template('edit')
    end

    it "should find the requested season" do
      Season.expects(:find).at_least(1).with(@params[:id]).returns(mock_season)
      do_get
    end

    it "should assign the found Round for the view" do
      Season.expects(:find).at_least(1).returns(mock_season)
      do_get
      assigns[:season].should equal(mock_season)
    end	  

  end

  describe "responding to PUT update season" do
  	
  	def do_put(params={})
  	  put :update, @params.merge(params)
  	end 	
  	
  	describe "with successful update" do

      it "should find the requested season" do
        Season.expects(:find).at_least(1).with(@params[:id]).returns(mock_season({:update_attributes => true}))
        do_put
      end

      it "should update the found season" do
        Season.stubs(:find).returns(mock_season)
        mock_season.expects(:update_attributes).with({'these' => 'params'})
        do_put :season => {:these => 'params'}
      end

      it "should assign the found season for the view" do
        Season.stubs(:find).returns(mock_season({:update_attributes => true}))
        do_put 
        assigns(:season).should equal(mock_season)
      end

      it "should redirect to the season" do
        Season.stubs(:find).returns(mock_season({:update_attributes => true}))
        do_put
        response.should redirect_to(season_url(mock_season))
      end

    end
    
    describe "with failed update" do

      it "should find the requested season" do
        Season.expects(:find).at_least(1).with(@params[:id]).returns(mock_season({:update_attributes => false}))
        do_put
      end

      it "should assign the season season for the view" do
        Season.stubs(:find).returns(mock_season({:update_attributes => false}))
        do_put
        assigns(:season).should equal(mock_season)
      end

      it "should re-render the 'edit' template" do
        Season.stubs(:find).returns(mock_season({:update_attributes => false}))
        do_put
        response.should render_template('edit')
      end

    end

  end

end
