# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe Role do
  fixtures :roles

  #
  # Validations
  #

  it 'requires name' do
    lambda do
      r = Role.create(:name => nil)
      r.errors.on(:name).should_not be_nil
    end.should_not change(Role, :count)
  end
end