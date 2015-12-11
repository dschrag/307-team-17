class Finance < ActiveRecord::Base
  belongs_to :user
    monetize :net_balance_cents
    monetize :net_income_cents
    monetize :net_expenses_cents
    monetize :income_last_month_cents
    monetize :expenses_last_month_cents

    def self.update_finances(user)
      @current_user = user
      @finance = Finance.find_by(user_id: user.id)
      calculate_balance
      calculate_income_and_outcome
      calculate_last_month_income_and_outcome
    end

    def self.calculate_balance
      balance = 0
      puts @current_user.name
      @current_user.transactions.each do |b|
        balance += b.price
      end
      puts balance
      @finance.net_balance = balance
      puts @finance.net_balance
      @finance.save!
    end

    def self.calculate_income_and_outcome
      income = 0
      outcome = 0
      @current_user.transactions.each do |b|
        if (b.price < 0)
          outcome += b.price
        else
          income += b.price
        end
      end

      @finance.net_income = income
      @finance.net_expenses = outcome
      @finance.save!
    end

    def self.calculate_last_month_income_and_outcome
      income = 0
      outcome = 0
      @current_user.transactions.each do |b|
        if (b.date_paid.month == Time.now.month)
          if (b.price < 0)
            income += b.price
          else
            outcome += b.price
          end
        end
      end

      @finance.income_last_month = income
      @finance.expenses_last_month = outcome
      @finance.save!
    end
end
