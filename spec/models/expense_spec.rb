require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user1) { Fabricate(:user) }
  let(:user2) { Fabricate(:user) }

  describe 'validations' do
    it { should validate_numericality_of(:total_amount).is_greater_than(0) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:date) }

    it 'validates splitted amount' do
      expense = Expense.new(total_amount: 100, description: 'For Tea', date: Date.today, paid_by_id: user1.id)
      expense.expense_participants.build(user: user1, amount_owed: 60)
      expense.expense_participants.build(user: user2, amount_owed: 40)

      expect(expense).to be_valid

      expense.total_amount = 90
      expect(expense).not_to be_valid
      expect(expense.errors[:base]).to include('Total amount is not equal to spltted amount')
    end
  end

  describe 'associations' do
    it { should belong_to(:paid_by_user).class_name('User').with_foreign_key('paid_by_id') }
    it { should have_many(:expense_participants).dependent(:destroy) }
    it { should have_many(:participants).through(:expense_participants).source(:user) }
    it { should accept_nested_attributes_for(:expense_participants) }
  end

  describe '#amount_owed_by' do
    it 'returns the amount owed by a user' do
      expense = Expense.new(total_amount: 100, description: 'Test expense', date: Date.today, paid_by_id: user1.id)
      expense.expense_participants.build(user: user1, amount_owed: 60)
      expense.expense_participants.build(user: user2, amount_owed: 40)
      expense.save

      expect(expense.amount_owed_by(user1)).to eq(60)
      expect(expense.amount_owed_by(user2)).to eq(40)
    end
  end
end
