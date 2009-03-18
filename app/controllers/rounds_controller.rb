class RoundsController < ApplicationController
  before_filter :find_season	
  before_filter :login_required, :only => [ :edit, :update, :publish ]
  require_role "admin", :only => [ :edit, :update, :publish ]
  
  # GET /seasons/1/rounds
  # GET /seasons/1/rounds.xml
  def index
    @rounds = @season.rounds.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rounds }
    end
  end

  # GET /seasons/1/rounds/1
  # GET /seasons/1/rounds/1.xml
  def show
    @round = @season.rounds.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @round }
    end
  end

  # GET /seasons/1/rounds/1/edit
  def edit
    @round = @season.rounds.find(params[:id])
  end

  # PUT /seasons/1/rounds/1
  # PUT /seasons/1/rounds/1.xml
  def update
    @round = @season.rounds.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        flash[:notice] = 'Round was successfully updated.'
        format.html { redirect_to season_round_path(@round.season, @round) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @round.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # get /seasons/1/rounds/1/publish
  def publish
  	@round = @season.rounds.find(params[:id])
  	if @round.valid? && @round.questions.not_valid.empty? && @round.update_attribute(:published, true)
  	  flash[:notice] = 'Round was successfully published.'  	  	  
	end
  	render :action => "show"	
  end
  
protected
  def find_season
  	@season = Season.find(params[:season_id])  	
  end
  
  def authorized?(action = nil, resource = nil)
  	case action
  	  when :publish
  	  	!@round.published && logged_in? && current_user.has_role?("admin")
  	else
  	  logged_in?
  	end
  end
end
