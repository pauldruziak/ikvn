class AnswersController < ApplicationController

  before_filter :find_question
  before_filter :check_round
  before_filter :users_only
  before_filter :check_user, :only => [:edit, :update]

  def new
    @answer = @question.answers.build
  end

  def create
    @answer = @question.answers.build(params[:answer])
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        flash[:notice] = 'Answer was successfully created.'
        format.html { redirect_to question_url(@answer.question) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @answer = @question.answers.find(params[:id])
  end

  def update
    @answer = @question.answers.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        flash[:notice] = 'Answer was successfully updated.'
        format.html { redirect_to question_url(@answer.question) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  protected

  def find_question
    @question = Question.find(params[:question_id])
  end

  def check_round
    question = Question.find(params[:question_id])
    if !question.round.open?
      flash[:error] = I18n.t('errors.messages.answer_prohibited_published_round')
      redirect_to season_url(question.round.season)
    end
  end

  def check_user
    answer = Question.find(params[:question_id]).answers.find(params[:id])
    if answer.user != current_user
      redirect_to season_round_question_url(@answer.question.round.season, @answer.question.round, @answer.question)
    end
  end

end

