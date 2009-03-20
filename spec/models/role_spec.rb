# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe Role do

  it { should validate_presence_of(:name) }
  
  it 'should create new role"' do
    lambda do
      Factory(:admin)
    end.should change(Role, :count)
  end
  

end