class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable


  has_many :expense_participants
  has_many :expenses, through: :expense_participants

  has_many :friends, -> (user) {  where.not(id: user.id).distinct }, through: :expenses, source: :participants

  scope :excluding_user, ->(user_id) { where.not(id: user_id) }

  def total_balance
    expense_participients.map(&:amount_owed).sum - expense_participants.map(&:amount_owed).sum
  end

  def expense_participants
    @expense_participants ||= ExpenseParticipant.includes(:expense, :user).where(expenses: { id: expenses.ids }, expenses: { paid_by_id: expenses.map(&:paid_by_id) }).where("expenses.paid_by_id != #{id} AND expenses.paid_by_id = expense_participants.user_id").order('expense_participants.created_at desc')
  end

  def expense_participients
    @expense_participients ||= ExpenseParticipant.includes(:expense, :user).where(expenses: { id: expenses.ids, paid_by_id: id }).where("expense_participants.user_id != #{id}").order('expense_participants.created_at desc')
  end
end
