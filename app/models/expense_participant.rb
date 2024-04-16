# app/models/expense_participant.rb
class ExpenseParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :expense

  validates :amount_owed, numericality: { greater_than_or_equal_to: 0 }

end
