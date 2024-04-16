class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.decimal :total_amount
      t.date :date
      t.string :description
      t.boolean :split_equally, default: true
      t.references :paid_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
