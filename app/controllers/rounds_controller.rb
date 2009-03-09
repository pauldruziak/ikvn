class RoundsController < ApplicationController
  before_filter :find_season	
	
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
  
protected
  def find_season
  	@season = Season.find(params[:season_id])
  	
  end
end
