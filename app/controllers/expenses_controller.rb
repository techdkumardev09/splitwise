# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  def create
    @expense = current_user.expenses.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created }
      else
        format.html { render :new }
        format.json { render json: @expense.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  private

  def expense_params
    params.require(:expense).permit(
      :total_amount, 
      :description, 
      :split_equally, 
      :paid_by_id, 
      :date, 
      expense_participants_attributes: [:id, :user_id, :amount_owed]
    )
  end
end
