class CreateExpenseParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_participants do |t|
      t.references :user
      t.references :expense
      t.decimal :amount_owed, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
