class UsersController < ApplicationController
  def new
    @user = User.new
  end


  def create
    raise Spam if params[:user][:age].present?
    @user = User.new(user_params)

    User.transaction do
      if @user.save
        @user.update_attributes!(persistence_token: SecureRandom.hex)
        self.current_user = @user
        redirect_to root_path
      else
        render :new
      end
    end
  end



  private

  def user_params
    params[:user].permit(:name, :email, :password, :confirmation_password)
  end
end
