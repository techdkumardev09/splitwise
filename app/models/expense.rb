class Expense < ApplicationRecord
  belongs_to :paid_by_user, class_name: "User", foreign_key: "paid_by_id"

  has_many :expense_participants, dependent: :destroy
  has_many :participants, through: :expense_participants, source: :user


end
