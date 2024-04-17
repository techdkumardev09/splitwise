Fabricator(:expense_participant) do
  user
  expense
  amount_owed { 0 }
end
