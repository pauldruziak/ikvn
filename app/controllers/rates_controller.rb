class RatesController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @question.answers.each do |answer|
      answer.rates.build(:user => current_user)
    end
  end

  def create
    @question = Question.find(params[:question_id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to question_url(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end
end
