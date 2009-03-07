class SeasonsController < ApplicationController
  
  before_filter :login_required, :only => [ :new, :create, :destroy]
  require_role "admin", :only => [ :new, :create, :destroy]
    
  # GET /seasons
  # GET /seasons.xml
  def index
    @seasons = Season.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seasons }
    end
  end

  # GET /seasons/1
  # GET /seasons/1.xml
  def show
    @season = Season.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @season }
    end
  end

  # GET /seasons/new
  # GET /seasons/new.xml
  def new
    @season = Season.new
	#@season.round_count = 5
	#@season.question_count = 5
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @season }
    end
  end
  
  # POST /seasons
  # POST /seasons.xml
  def create
    @season = Season.new(params[:season])

    respond_to do |format|
      if @season.save      	
        flash[:notice] = 'Season was successfully created.'
        format.html { redirect_to(@season) }
        format.xml  { render :xml => @season, :status => :created, :location => @season }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @season.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seasons/1
  # DELETE /seasons/1.xml
  def destroy
    @season = Season.find(params[:id])
    @season.destroy

    respond_to do |format|
      format.html { redirect_to(seasons_url) }
      format.xml  { head :ok }
    end
  end 

end
