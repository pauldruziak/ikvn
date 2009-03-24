require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestionsController do
	
  def mock_season(stubs={})
  	stubs = {
  	  :id => "1",
  	  :rounds => []
    }.merge(stubs)
  	@mock_season ||= stub("season", stubs)
  end
  
  def mock_round(stubs={})
  	stubs = {
  	  :id => "2", 	 
  	  :published => false,
  	  :season => mock_season, 
  	  :questions => []
    }.merge(stubs)
  	@mock_round ||= stub("round", stubs)
  end

  def mock_question(stubs={})
  	stubs = {
  	  :id => "2",
  	  :round => mock_round  	   	  
    }.merge(stubs)
    @mock_question ||= stub("question", stubs)
  end 
  
  before(:all) do
    @params = {:season_id => "1", :round_id => "2", :id => "2"}    
  end
  
  describe "before filter" do
  	
    it "should have find_round" do
      controller.before_filters.should include(:find_round)
    end 
    
    it "should have check_round" do
      controller.before_filters.should include(:check_round)
    end 
    
    describe "find_round" do
      it "should find a round" do
        Season.expects(:find).with(@params[:season_id]).returns(mock_season)
        mock_season.rounds.expects(:find).with(@params[:round_id])
        controller.run_filter(:find_round, @params)
      end
    end
    
    describe "check_round" do
    	
      it "should have options" do
        controller.before_filter(:check_round).should have_options(:only => [:edit, :update])
      end
    
      it "should check a round for publishing" do
        Season.expects(:find).with(@params[:season_id]).returns(mock_season)
        mock_season.rounds.expects(:find).with(@params[:round_id]).returns(mock_round)
        mock_round.expects(:published)
        controller.run_filter(:check_round, @params)
      end
      
      describe "when round published" do
      	
      	def do_get
      	  get :edit, @params
      	end
      
        before(:each) do
	      Season.stubs(:find).returns(mock_season)
          mock_season.rounds.stubs(:find).returns(mock_round({:published => true}))
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
  
  describe "responding to GET show question" do
	def do_get
	  get :show, @params
	end
	
	before(:each) do
	  Season.stubs(:find).returns(mock_season)
      mock_season.rounds.stubs(:find).returns(mock_round)
	end
	
	it "should succeed" do      
      mock_round.questions.stubs(:find)
      do_get
      response.should be_success
    end

    it "should render the 'show' template" do      
      mock_round.questions.stubs(:find)
      do_get 
      response.should render_template('show')
    end    
    
    it "should find the requested question" do         
      mock_round.questions.expects(:find).with(@params[:id])      
      do_get 
    end

    it "should assign the found question for the view" do     
      mock_round.questions.expects(:find).returns(mock_question)
      do_get
      assigns[:question].should equal(mock_question)      
    end
    
  end
  
  describe "responding to GET edit question" do
  	
  	def do_get
  	  get :edit, @params
  	end  	
  	
  	before(:each) do
      Season.stubs(:find).returns(mock_season)
      mock_season.rounds.stubs(:find).returns(mock_round({:published => false}))
    end
  	
    it "should succeed" do
      mock_round.questions.stubs(:find)
      do_get 
      response.should be_success
    end

    it "should render the 'edit' template" do
      mock_round.questions.stubs(:find)
      do_get
      response.should render_template('edit')
    end

    it "should find the requested question" do
      mock_round.questions.expects(:find).with(@params[:id])
      do_get
    end

    it "should assign the found Question for the view" do
      mock_round.questions.expects(:find).returns(mock_question)
      do_get
      assigns[:question].should equal(mock_question)
    end	  

  end
  
  describe "responding to PUT update question" do
  	
  	def do_put(params={})
  	  put :update, @params.merge(params)
  	end 	
      	
  	before(:each) do
      Season.stubs(:find).returns(mock_season)
      mock_season.rounds.stubs(:find).returns(mock_round({:published => false}))
    end
  	
  	describe "with successful update" do

      it "should find the requested question" do
        mock_round.questions.expects(:find).with(@params[:id]).returns(mock_question({:update_attributes => true}))
        do_put
      end

      it "should update the found question" do
        mock_round.questions.stubs(:find).returns(mock_question)
        mock_question.expects(:update_attributes).with({'these' => 'params'})
        do_put :question => {:these => 'params'}
      end

      it "should assign the found question for the view" do
        mock_round.questions.stubs(:find).returns(mock_question({:update_attributes => true}))
        do_put 
        assigns(:question).should equal(mock_question)
      end

      it "should redirect to the question" do
        mock_round.questions.stubs(:find).returns(mock_question({:update_attributes => true}))
        do_put
        response.should redirect_to(season_round_question_url(mock_season, mock_round, mock_question))
      end

    end
    
    describe "with failed update" do

      it "should find the requested question" do
        mock_round.questions.expects(:find).with(@params[:id]).returns(mock_question({:update_attributes => false}))
        do_put
      end

      it "should assign the found question for the view" do
        mock_round.questions.stubs(:find).returns(mock_question({:update_attributes => false}))
        do_put
        assigns(:question).should equal(mock_question)
      end

      it "should re-render the 'edit' template" do
        mock_round.questions.stubs(:find).returns(mock_question({:update_attributes => false}))
        do_put
        response.should render_template('edit')
      end

    end

  end
  
end