require File.dirname(__FILE__) + '/../test_helper'

class SeasonsControllerTest < ActionController::TestCase

  signed_in_admin_context do

    context "on GET to :new" do
      setup do
        @season = Factory(:season)
        Season.stubs(:new).returns(@season)
        get :new
      end
      should_assign_to(:season) { @season }
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
    end

    context "on POST to :create" do
      setup do
        @season_attrs = Factory.attributes_for(:season)
        @season = Factory(:season)
        Season.stubs(:new).returns(@season)
      end
      context "with valid attributes" do
        setup do
          @season.stubs(:save).returns(true)
          post :create, :season => @season_attrs
        end

        should_assign_to(:season) { @season }
        should_respond_with :redirect
        should_set_the_flash_to 'Season was successfully created.'
        should_redirect_to("the season page"){ season_url(@season) }
      end

      context "with invalid attributes" do
        setup do
          @season.stubs(:save).returns(false)
          post :create, :season => @season_attrs
        end

        should_assign_to(:season) { @season }
        should_respond_with :success
        should_not_set_the_flash
        should_render_template :new
      end
    end

    context "on GET to :edit" do
      setup do
        @season = Factory(:season)
        Season.stubs(:find).with(@season.id.to_s).returns(@season)
        Season.stubs(:find).with(:all, :order => "id DESC").returns([@season])
      end

      context "on not published season" do
        setup do
          @season.expects(:published?).returns(false)
          get :edit, :id => @season.id
        end

        should_assign_to(:season) { @season }
        should_respond_with :success
        should_render_template :edit
        should_not_set_the_flash
      end

      context "on published season" do
        setup do
          @season.expects(:published?).returns(true)
          get :edit, :id => @season.id
        end

        should_redirect_to("the season page") { season_url(@season) }
        should_respond_with :redirect
        should_assign_to(:season) { @season }
        should_set_the_flash_to I18n.t('errors.messages.season_prohibited_published_round')
      end

    end

    context "on PUT to :update" do
      setup do
        @season = Factory(:season)
        Season.stubs(:find).with(@season.id.to_s).returns(@season)
        Season.stubs(:find).with(:all, :order => "id DESC").returns([@season])
      end
      context "on not published season" do
        setup do
          Season.any_instance.expects(:published?).returns(false)
        end

        context "with valid attributes" do
          setup do
            Season.any_instance.expects(:update_attributes).with(@season).returns(true)
            put :update, :id => @season.id, :season => @season
          end

          should_assign_to :season
          should_respond_with :redirect
          should_assign_to(:season) { @season }
          should_redirect_to("season page") { season_url(@season) }
          should_set_the_flash_to "Season was successfully updated."
        end

        context "with invalid attributes" do
          setup do
            Season.any_instance.expects(:update_attributes).with(@season).returns(false)
            put :update, :id => @season.id, :season => @season
          end

          should_assign_to(:season) { @season }
          should_respond_with :success
          should_not_set_the_flash
          should_render_template :edit
        end

      end

      context "on published season" do
        setup do
          Season.any_instance.expects(:published?).returns(true)
          put :update, :id => @season.id, :season => @season
        end

        should_redirect_to("the season page") { season_url(@season) }
        should_respond_with :redirect
        should_assign_to(:season) { @season }
        should_set_the_flash_to I18n.t('errors.messages.season_prohibited_published_round')
      end
    end

  end

  public_context do

    context "on GET to :new" do
      setup { get :new }
      should_deny_access(:flash => /Please Login as an administrator/i)
    end

  end
end
