class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  after_action :update_finances

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = current_user.transactions
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @seller = House.find(current_user.relationship.house_id).users.where(name: @transaction.seller).first
    @buyer = House.find(current_user.relationship.house_id).users.where(name: @transaction.buyer).first
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id

    if @seller = House.find(current_user.relationship.house_id).users.where(name: @transaction.seller)
      if (!(@seller.first.nil?) && (@seller.first.id != current_user.id))
        puts "FOUND SELLER"
        @sellertransaction = Transaction.new(transaction_params)
        @sellertransaction.user_id = @seller.first.id
        @sellertransaction.price = @sellertransaction.price * -1
        @sellertransaction.save
      end
    end

    if @buyer = House.find(current_user.relationship.house_id).users.where(name: @transaction.buyer)
      if (!(@buyer.first.nil?) && (@buyer.first.id != current_user.id))
        puts "FOUND buyer"
        @buyertransaction = Transaction.new(transaction_params)
        @buyertransaction.user_id = @buyer.first.id
        @buyertransaction.price = @buyertransaction.price * -1
        @buyertransaction.save
      end
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_finances
    Finance.update_finances(current_user)
    puts current_user.finance.net_balance_cents
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:user_id, :buyer, :buyer, :seller, :recurring, :reason, :date_due, :date_paid, :price)
    end
end
