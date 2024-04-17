Fabricator(:expense) do
  total_amount { Faker::Number.between(from: 10, to: 100) }
  date { Faker::Date.backward(days: 30) }
  description { Faker::Lorem.sentence }
  split_equally { Faker::Boolean.boolean }
  paid_by_id { Fabricate(:user).id }
end
