# spec/services/dashboard_service_spec.rb
require 'rails_helper'

RSpec.describe DashboardService do
  let(:current_user) { Fabricate(:user) }
  let(:user1) { Fabricate(:user, name:'user1') }
  let(:user2) { Fabricate(:user, name: 'user2') }

  describe "dashboard_data" do
    let(:dashboard_service) { DashboardService }

    let(:expense) { Expense.new( paid_by_id: current_user.id, total_amount: 100,
                                  split_equally: true, description: 'bill paid', date: Date.today) }

    let!(:participant1) { expense.expense_participants.build(user: current_user, amount_owed: 40) }
    let!(:participant2) { expense.expense_participants.build(user: user1, amount_owed: 60) }

    before do
      expense.save!
    end

    it "should return current user data on dashboard" do
      expected_data = {
        you_owe_details: [],
        owed_to_you_details: [],
        you_owe_amount: 0,
        owed_to_you_amount: participant2.amount_owed,
        total_balance: current_user.total_balance,
        friends: current_user.friends
      }

      response = dashboard_service.new(current_user).dashboard_data
      expect(response[:owed_to_you_amount].to_i).to eq(expected_data[:owed_to_you_amount])
      expect(response[:total_balance].to_i).to eq(expected_data[:total_balance])
      expect(response[:friends]).to eq(expected_data[:friends])
    end
  end
end
