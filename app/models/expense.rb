class Expense < ApplicationRecord
  belongs_to :paid_by_user, class_name: "User", foreign_key: "paid_by_id"

  has_many :expense_participants, dependent: :destroy
  has_many :participants, through: :expense_participants, source: :user

  accepts_nested_attributes_for :expense_participants

  validates :total_amount, numericality: { greater_than: 0 }
  validates :description, :date, presence: true

  validate :validate_splitted_amount

  def amount_owed_by(user)
    expense_participants.find_by(user_id: user.id).amount_owed
  end

  private

  def validate_splitted_amount
    return if expense_participants.map(&:amount_owed).sum == total_amount

    errors.add(:base, 'Total amount is not equal to spltted amount')
  end
end
