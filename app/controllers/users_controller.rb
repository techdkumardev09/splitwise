class UsersController < ApplicationController

  def index
    @users =  User.excluding_user(current_user.id)
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

end
