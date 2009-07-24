require File.dirname(__FILE__) + '/../test_helper'

class QuestionsControllerTest < ActionController::TestCase
  public_context do
    context "on GET to :show" do
      setup do
        @question = Question.generate!
        Question.stubs(:find).with(@question.id.to_s).returns(@question)
        Question.stubs(:find).with(:all, {:include => nil, :readonly => nil, :select => nil, :offset => nil, :group => nil, :joins => nil, :limit => nil, :conditions => "`questions`.round_id = #{@question.round.id}"}).returns([@question])
      end

      context "questin on published round" do
        setup do
          @question.round.stubs(:published?).returns(true)
          get :show, :id => @question.id
        end

        should_respond_with :success
        should_assign_to :question
        should_render_template :show
        should_not_set_the_flash
      end

      context "question on not published round" do
        setup do
          @question.round.stubs(:published?).returns(false)
          get :show, :id => @question.id
        end

        should_respond_with :redirect
        should_redirect_to("main page") { current_seasons_url }
        should_set_the_flash_to 'Access denied.'
      end
    end
  end

  user_context do
    setup do
      @question = Question.g
    end
  end
  #should_deny_access(:flash => /Please Login as an administrator/i)
end
