json.extract! expense, :id, :money, :note, :other_category, :created_at, :updated_at
json.url expense_url(expense, format: :json)
