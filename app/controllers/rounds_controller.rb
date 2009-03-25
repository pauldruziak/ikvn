class RoundsController < ApplicationController
	
  before_filter :find_season	
  before_filter :check_round, :only => [:edit, :update, :publish]
  
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
    else
      #TODO refactoring
      @not_published = true
	end
  	render :action => "show"	
  end
  
protected
  def find_season
  	@season = Season.find(params[:season_id])  	
  end
  
  def check_round
  	@round = Season.find(params[:season_id]).rounds.find(params[:id])
  	if @round.published
  	  flash[:error] = I18n.t('errors.messages.round_prohibited_published_round')
  	  redirect_to season_round_url(@round.season, @round)
  	  false
  	end
  end
end
