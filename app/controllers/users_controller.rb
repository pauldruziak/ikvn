class UsersController < ApplicationController
  include Clearance::App::Controllers::UsersController
  
  layout 'authentication', :only => [ :new ]
  #layout 'application', :only => [ :show, :index ]
    
  before_filter :admin_only, :only => [ :index, :show ]
  before_filter :get_user, :only => [ :edit, :update ]
  
  def index
    @users = User.find :all
    render :layout => "application"
  end
  
  def show
    @user = User.find(params[:id])
    render :layout => "application"
  end
  
  def edit
    render :layout => "application"
  end
  
  def update
    if signed_in_as_admin? #&& params[:user][:admin] && params[:user][:admin] == "1"
      @user.admin = false
      @user.judge = true
      @user.save
    elsif signed_in_as_admin?
      @user.admin = false
      @user.save
    end
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User Record was successfully updated.'
        format.html { redirect_to(edit_user_url(@user)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end  
    render :layout => "application"
  end
  
  protected
  
  def get_user
    if signed_in_as_admin?
      @user = User.find(params[:id])
    elsif signed_in?
      @user = current_user
    end
  end
end