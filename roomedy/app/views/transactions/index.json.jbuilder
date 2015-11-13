json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :user_id, :buyer, :seller, :recurring, :reason, :date_due, :date_paid
  json.url transaction_url(transaction, format: :json)
end
