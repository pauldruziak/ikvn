class SessionsController < ApplicationController
  include Clearance::App::Controllers::SessionsController
  layout 'authentication'
end
