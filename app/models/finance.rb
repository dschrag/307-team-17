class Finance < ActiveRecord::Base
  belongs_to :user
  monetize :net_balance_cents

  def self.update_finances(user)
    @current_user = user
    @finance = Finance.find_by(user_id: user.id)
    calculate_balance
  end

  def self.calculate_balance
    balance = 0
    puts @current_user.name
    @current_user.transactions.each do |b|
      puts b.price
      balance += b.price
    end
    puts balance
    @finance.net_balance = balance
    puts @finance.net_balance
    @finance.save!
  end

end
