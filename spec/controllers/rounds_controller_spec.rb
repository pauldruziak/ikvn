require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoundsController do
	
  def mock_season(stubs={})
  	stubs = {
  	  :id => 1,
  	  :rounds => []
  	}.merge(stubs)
  	@mock_season ||= stub("season", stubs)
  end
  
  def mock_round(stubs={})
  	stubs = {
  	  :id => 37,
  	  :published => false,
  	  :valid? => true,
  	  :questions => [],
  	  :season => mock_season
  	}.merge(stubs)
  	@mock_round ||= stub("round", stubs)
  	@mock_round.questions.stubs(:not_valid).returns({})
  	@mock_round
  end

  before(:all) do
    @params = { :season_id => "1", :id => "37" }
  end
  
  describe "before filter" do
  	
    it "should have find_season" do
      controller.before_filters.should include(:find_season)
    end 
    
    it "should have check_round" do
      controller.before_filters.should include(:check_round)
    end 
    
    describe "find_season" do
      it "find_season should find a round" do
        Season.expects(:find).with(@params[:season_id]).returns(mock_season)
        controller.run_filter(:find_season, @params)
      end
    end
    
    describe "check_round" do
    	
      it "check_round should have options" do
        controller.before_filter(:check_round).should have_options(:only => [:edit, :update, :publish])
      end
    
      it "check_round should check a round for publishing" do
        Season.expects(:find).with(@params[:season_id]).returns(mock_season)
        mock_season.rounds.expects(:find).with(@params[:id]).returns(mock_round)
        mock_round.expects(:published)
        controller.run_filter(:check_round, @params)
      end
      
      describe "when round published" do
      	
      	def do_get
      	  get :edit, @params
      	end
      
        before(:each) do
	      Season.stubs(:find).returns(mock_season)
          mock_season.rounds.stubs(:find).with(@params[:id]).returns(mock_round({:published => true}))
	    end
	
	  	it "should have flash" do	  	  
	  	  do_get
	  	  flash[:error].should_not be_nil
	  	end
	  	
	  	it "should redirect to show round" do
	  	  do_get
	  	  response.should redirect_to(season_round_path(mock_round.season, mock_round))
	  	end
	  	
	  	it "should assign the found Round for the view" do	      
	      do_get
	      assigns[:round].should equal(mock_round)
	    end
	    
	  end
      
    end   
    
  end
  
  describe "responding to GET show round" do
	def do_get
	  get :show, @params
	end
	
	before(:each) do
	  Season.stubs(:find).returns(mock_season)      
	end
	
	it "should succeed" do      
      mock_season.rounds.stubs(:find)	      
      do_get
      response.should be_success
    end

    it "should render the 'show' template" do      
      mock_season.rounds.stubs(:find)
      do_get 
      response.should render_template('show')
    end    
    
    it "should find the requested round" do         
      mock_season.rounds.expects(:find).with(@params[:id])      
      do_get 
    end

    it "should assign the found round for the view" do     
      mock_season.rounds.expects(:find).returns(mock_round)
      do_get
      assigns[:round].should equal(mock_round)      
    end
    
  end

  describe "responding to GET edit round" do
  	
  	def do_get
  	  get :edit, @params
  	end  	
  	
  	before(:each) do
      Season.stubs(:find).returns(mock_season)      
    end
  	
    it "should succeed" do
      mock_season.rounds.stubs(:find).returns(mock_round)
      do_get 
      response.should be_success
    end

    it "should render the 'edit' template" do
      mock_season.rounds.stubs(:find).returns(mock_round)
      do_get
      response.should render_template('edit')
    end

    it "should find the requested round" do
      mock_season.rounds.expects(:find).at_least(1).with(@params[:id]).returns(mock_round)
      do_get
    end

    it "should assign the found Round for the view" do
      mock_season.rounds.expects(:find).at_least(1).returns(mock_round)
      do_get
      assigns[:round].should equal(mock_round)
    end	  

  end

  describe "responding to PUT update round" do
  	
  	def do_put(params={})
  	  put :update, @params.merge(params)
  	end 	
      	
  	before(:each) do
      Season.stubs(:find).returns(mock_season)      
    end
  	
  	describe "with successful update" do

      it "should find the requested round" do
        mock_season.rounds.expects(:find).at_least(1).with(@params[:id]).returns(mock_round({:update_attributes => true}))
        do_put
      end

      it "should update the found round" do
        mock_season.rounds.stubs(:find).returns(mock_round)
        mock_round.expects(:update_attributes).with({'these' => 'params'})
        do_put :round => {:these => 'params'}
      end

      it "should assign the found round for the view" do
        mock_season.rounds.stubs(:find).returns(mock_round({:update_attributes => true}))
        do_put 
        assigns(:round).should equal(mock_round)
      end

      it "should redirect to the round" do
        mock_season.rounds.stubs(:find).returns(mock_round({:update_attributes => true}))
        do_put
        response.should redirect_to(season_round_url(mock_season, mock_round))
      end

    end
    
    describe "with failed update" do

      it "should find the requested round" do
        mock_season.rounds.expects(:find).at_least(1).with(@params[:id]).returns(mock_round({:update_attributes => false}))
        do_put
      end

      it "should assign the found round for the view" do
        mock_season.rounds.stubs(:find).returns(mock_round({:update_attributes => false}))
        do_put
        assigns(:round).should equal(mock_round)
      end

      it "should re-render the 'edit' template" do
        mock_season.rounds.stubs(:find).returns(mock_round({:update_attributes => false}))
        do_put
        response.should render_template('edit')
      end

    end

  end
  
  
  describe "responding to GET publish" do
  	before(:each) do
      Season.stubs(:find).returns(mock_season)      
    end
  	
  	def do_get
  	  get :publish, @params
  	end
    
    it "should find the requested round" do
        mock_season.rounds.expects(:find).at_least(1).with(@params[:id]).returns(mock_round({:update_attribute => true}))
        do_get
      end

      it "should publish the found round" do
        mock_season.rounds.stubs(:find).returns(mock_round)
        mock_round.expects(:update_attribute).with(:published, true)
        do_get
      end

      it "should assign the found round for the view" do
        mock_season.rounds.stubs(:find).returns(mock_round({:update_attribute => true}))
        do_get 
        assigns(:round).should equal(mock_round)
      end

      it "should redirect to the round" do
        mock_season.rounds.stubs(:find).returns(mock_round({:update_attribute => true}))
        do_get
        response.should redirect_to(season_round_url(mock_season, mock_round))
      end
  end

end
