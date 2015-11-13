class Transaction < ActiveRecord::Base
  belongs_to :user
  monetize :price_cents
end
