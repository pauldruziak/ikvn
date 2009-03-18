require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include AuthenticatedSystem
describe RoundsController do

  def mock_round(options={})
    @mock_round ||= mock_model(Round, { :name => "1",
    									:season_id => 1, 
    									:season => mock_season, 
  	                                    :published => false, 
  	                                    :start_responses_at => Time.now,
  					                    :end_responses_at => Time.now + 14.day,
						                :start_assess_at => Time.now + 14.day, 
  						                :end_assess_at => Time.now + 21.day}.merge(options))
  end
  
  def mock_season(options={})
  	@mock_season ||= mock_model(Season, { :id => 1,
  										  :name => "first",
  										  :rounds => []}.merge(options))
  end
  def mock_admin
    @admin ||= mock_model(User, :id => 1,
						       :login  => 'user_name',
						       :name   => 'U. Surname',
						       :to_xml => "User-in-XML", :to_json => "User-in-JSON", 
						       :errors => [], 
						       :roles  => [mock_model(Role, {:name => "admin", :save => true})])  
  end
  before do
    @params = { :season_id => "1", :id => "37" }
  end
  
  describe "responding to GET index" do
  	def do_get
      get :index, @params
  	end

    it "should expose all rounds as @rounds" do      
      Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
      mock_season.rounds.should_receive(:find).with(:all).and_return([mock_round])
      do_get
      assigns[:rounds].should == [mock_round]
    end

    describe "with mime type of xml" do
  
      it "should render all rounds as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
        mock_season.rounds.should_receive(:find).with(:all).and_return(rounds = mock("Array of Rounds"))
        rounds.should_receive(:to_xml).and_return("generated XML")
        do_get
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do
  	def do_get
  	  get :show, @params
  	end

    it "should expose the requested round as @round" do
      Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)      
      mock_season.rounds.should_receive(:find).with(@params[:id]).and_return(mock_round)
      do_get
      assigns[:round].should equal(mock_round)
    end
    
    describe "with mime type of xml" do

      it "should render the requested round as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
        mock_season.rounds.should_receive(:find).with(@params[:id]).and_return(mock_round)
        mock_round.should_receive(:to_xml).and_return("generated XML")
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
  
    it "should expose the requested round as @round" do
      Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
      mock_season.rounds.should_receive(:find).with(@params[:id]).and_return(mock_round)
      do_get
      assigns[:round].should equal(mock_round)
    end

  end

  describe "responding to PUT udpate" do

    describe "with valid params" do
      def do_put(options={})
      	put :update, @params.merge(options)
      end

      it "should update the requested round" do
      	Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
        mock_season.rounds.should_receive(:find).with(@params[:id]).and_return(mock_round)
        mock_round.should_receive(:update_attributes).with({'these' => 'params'})
        do_put(:round => {'these' => 'params'})
      end

      it "should expose the requested round as @round" do
      	Season.stub!(:find).and_return(mock_season)
        mock_season.rounds.stub!(:find).and_return(mock_round(:update_attributes => true))
        do_put
        assigns(:round).should equal(mock_round)
      end

      it "should redirect to the round" do
      	Season.stub!(:find).and_return(mock_season)
        mock_season.rounds.stub!(:find).and_return(mock_round(:update_attributes => true))
        do_put
        response.should redirect_to(season_round_url(mock_season, mock_round))
      end

    end
    
    describe "with invalid params" do
      def do_put(options={})
      	put :update, @params.merge(options)
      end

      it "should update the requested round" do
      	Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
        mock_season.rounds.should_receive(:find).with(@params[:id]).and_return(mock_round)
        mock_round.should_receive(:update_attributes).with({'these' => 'params'})
        do_put :round => {:these => 'params'}
      end

      it "should expose the round as @round" do
      	Season.stub!(:find).and_return(mock_season)
        mock_season.rounds.stub!(:find).and_return(mock_round(:update_attributes => false))
        do_put
        assigns(:round).should equal(mock_round)
      end

      it "should re-render the 'edit' template" do
      	Season.stub!(:find).and_return(mock_season)
        mock_season.rounds.stub!(:find).and_return(mock_round(:update_attributes => false))
        do_put
        response.should render_template('edit')
      end

    end

  end
  
  
  describe "responding to GET publish" do
  	def do_get
  	  get :publish, @params
  	end
    it "should publish the request round" do
      Season.should_receive(:find).with(@params[:season_id]).and_return(mock_season)
      mock_season.rounds.should_receive(:find).with(@params[:id]).and_return(mock_round)
      mock_round.should_receive(:update_attribute).with(:published, true) 
      do_get
    end
  end
  end

end
