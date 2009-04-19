class SeasonsController < ApplicationController
	
  before_filter :check_round,  :only => [:edit, :update, :destroy]  
  before_filter :admin_only, :only => [:new, :create, :edit, :update, :destroy]  
  
  # GET /seasons/current
  # GET /seasons/current.xml
  def current
  	@season = Season.current

    respond_to do |format|
      format.html { render :action => "show" }
      format.xml  { render :action => "show", :xml => @season }
    end
  end
  
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
    
    if @season.published? || signed_in_as_admin?
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @season }
      end
    else
      redirect_to current_seasons_url
    end
  end

  # GET /seasons/new
  # GET /seasons/new.xml
  def new
    @season = Season.new
 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @season }
    end
  end
  
  def edit
  	@season = Season.find(params[:id])
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
  
  def update
  	@season = Season.find(params[:id])

    respond_to do |format|
      if @season.update_attributes(params[:season])
        flash[:notice] = 'Season was successfully updated.'
        format.html { redirect_to season_url(@season) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
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
      format.html { redirect_to(current_seasons_url) }
      format.xml  { head :ok }
    end
  end 

protected

  def check_round
    @season = Season.find(params[:id])    	
    if @season.published?
	  flash[:error] = I18n.t('errors.messages.season_prohibited_published_round')
  	  redirect_to season_url(@season)
    end
  end  

end
