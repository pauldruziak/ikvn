class QuestionsController < ApplicationController

  before_filter :find_round
  before_filter :check_round, :only => [:edit, :update]
  before_filter :admin_only, :only => [:edit, :update]

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = @round.questions.find(params[:id])

    if @question.round.published || signed_in_as_admin?
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @question }
      end
    else
      redirect_to season_round_path(@question.round.season, @question.round)
    end
  end

  # GET /questions/1/edit
  def edit
    @question = @round.questions.find(params[:id])
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = @round.questions.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to season_round_question_url(@question.round.season, @question.round, @question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected
  def find_round
    @round = Season.find(params[:season_id]).rounds.find(params[:round_id])
  end

  def check_round
    @round = Season.find(params[:season_id]).rounds.find(params[:round_id])
    if @round.published
      flash[:error] = I18n.t('errors.messages.question_prohibited_published_round')
      redirect_to season_round_url(@round.season, @round)
      false
    end
  end
end

