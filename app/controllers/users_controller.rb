class UsersController < ApplicationController

  def index
    @users =  User.excluding_user(current_user.id)
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def add_participant
    @user = User.invite!(user_params)
    if @user.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created }
      end
    else
      respond_to do |format|
        format.html
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
