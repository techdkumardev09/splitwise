# app/services/dashboard_service.rb
class DashboardService
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def dashboard_data
    map_dashboard_data
  end

  private

  def map_dashboard_data
    { 
      you_owe_details: you_owe_details,
      owed_to_you_details: owed_to_you_details,
      you_owe_amount: you_owe_amount,
      owed_to_you_amount: owed_to_you_amount,
      total_balance: user.total_balance,
      friends: user.friends
    }
  end

  def you_owe_amount
    you_owe_details.collect {|detail| detail[:amount]}.sum
  end

  def owed_to_you_amount
    owed_to_you_details.collect {|detail| detail[:amount]}.sum
  end

  def you_owe_details
    @you_owe_details ||= calculate_details('you_owe')
  end

  def owed_to_you_details
    @owed_to_you_details ||= calculate_details('owed_to_you')
  end

  def calculate_details(type)
    participants_total = {}
    expense_users = type == 'you_owe' ? user.expense_participants : user.expense_participients
    
    expense_users.each do |participant|
      participants_total[participant.user_id] ||= { amount_owed: 0 }
      participants_total[participant.user_id][:amount_owed] += participant.amount_owed
      participants_total[participant.user_id][:name] ||= participant.user.name
    end

    details = participants_total.collect do|user_id, data|
      participants = if type == 'you_owe'
        user.expense_participients.select  { |ep| ep if ep.user_id == user_id }
      else
        user.expense_participants.select  { |ep| ep if ep.user_id == user_id }
      end
      amount = (data[:amount_owed] - participants.map(&:amount_owed).sum)
      { name: data[:name], amount: amount } if amount > 0
    end
    details.compact
  end
end
