class SessionsController < ApplicationController
  def new
  end


  def create
    user = User.find_by_name(params[:session][:name])

    if user && user.authenticate(params[:session][:password])
      self.current_user = user
    end

    redirect_to(root_path)
  end


  def destroy
    self.current_user = nil
    redirect_to(root_path)
  end
end
