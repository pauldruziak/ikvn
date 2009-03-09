require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include AuthenticatedSystem
describe QuestionsController do
	
  def mock_season(options={})
  	@mock_season ||= mock_model(Season, { :name => 'first season', 
  	                                      :rounds => []}.merge(options))
  end
  
  def mock_round(options={})
  	@mock_round ||= mock_model(Round, { :name => 'first season',
  	                                    :questions => [], 
  	                                    :season => mock_season}.merge(options))
  end

  def mock_question(options={})
    @mock_question ||= mock_model(Question, { :name => 'first question',
                                              :body => 'body question',
                                              :update_attributes => true, 
                                              :round => mock_round}.merge(options))
  end
  
  def mock_admin
    @admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
  end
  
  before(:each) do
    @params = {:season_id => "7", :round_id => "2", :id => "4"}
    
  end
  
  describe "responding to GET show" do
	def do_get
	  get :show, @params
	end
	
	before(:each) do
	  Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
      mock_season.rounds.should_receive(:find).with(@params[:round_id]).and_return(mock_round)
      mock_round.questions.should_receive(:find).with(@params[:id]).and_return(mock_question)
	end

    it "should expose the requested question as @question" do      
      do_get
      assigns[:question].should equal(mock_question)
    end
    
    describe "with mime type of xml" do

      it "should render the requested question as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock_question.should_receive(:to_xml).and_return("generated XML")
        do_get
        response.body.should == "generated XML"
      end

    end
    
  end
  describe "with login as admin" do
    
  	before(:each) do
      login_as mock_admin
	  current_user.stub!(:has_role?).and_return(true)
	  controller.stub!(:check_roles).and_return(true)
    end
    
  describe "responding to GET edit" do
  	def do_get
  	  get :edit, @params
  	end
  
    it "should expose the requested question as @question" do      
      Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
      mock_season.rounds.should_receive(:find).with(@params[:round_id]).and_return(mock_round)
      mock_round.questions.should_receive(:find).with(@params[:id]).and_return(mock_question)
      do_get
      assigns[:question].should equal(mock_question)
    end

  end

   describe "responding to PUT udpate" do
   	 before(:each) do
	   Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
       mock_season.rounds.should_receive(:find).with(@params[:round_id]).and_return(mock_round)     
	 end
	 
	 def do_put
	   put :update, @params.merge(:question => {:these => 'params'})
	 end 

    describe "with valid params" do

      it "should update the requested question" do
        mock_round.questions.should_receive(:find).with(@params[:id]).and_return(mock_question)
        mock_question.should_receive(:update_attributes).with({'these' => 'params'})
        do_put
      end

      it "should expose the requested question as @question" do
        mock_round.questions.stub!(:find).and_return(mock_question(:update_attributes => true))
        do_put
        assigns(:question).should equal(mock_question)
      end

      it "should redirect to the question" do
        mock_round.questions.stub!(:find).and_return(mock_question(:update_attributes => true))
        do_put
        response.should redirect_to(season_round_question_url(mock_season, mock_round, mock_question))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested question" do
        mock_round.questions.should_receive(:find).with(@params[:id]).and_return(mock_question)
        mock_question.should_receive(:update_attributes).with({'these' => 'params'})
        do_put
      end

      it "should expose the question as @question" do
        mock_round.questions.stub!(:find).and_return(mock_question(:update_attributes => false))
        do_put
        assigns(:question).should equal(mock_question)
      end

      it "should re-render the 'edit' template" do
        mock_round.questions.stub!(:find).and_return(mock_question(:update_attributes => false))
        do_put
        response.should render_template('edit')
      end

    end

  end

  end
end
