class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #require 'sessions_helper.rb'
  include SessionsHelper


end
