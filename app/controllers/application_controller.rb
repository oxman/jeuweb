class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user


  private

  def current_user=(user)
    cookies.permanent.signed[:persistence_token] = user && user.persistence_token
  end


  def current_user
    return nil unless cookies.signed[:persistence_token]
    @current_user ||= User.find_by_persistence_token(cookies.signed[:persistence_token]).decorate
  end


  class Spam < StandardError; end
end
