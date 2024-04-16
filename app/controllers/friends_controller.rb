# app/controllers/expenses_controller.rb
class FriendsController < ApplicationController

  before_action :set_friend, :set_expenses, only: :show

  private

  def set_friend
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to root_path unless @friend.present?
  end

  def set_expenses
    @expenses = @friend.expenses.order(created_at: :desc)
  end
end
