class ItemsController < ApplicationController
    
    def new
        @item = Item.new
    end
    
    def create
        @item = current_user.items.build(item_params)
        if @item.save
            flash[:success] = "Item Created."
            redirect_to items_path
        else
            render 'new'
        end
    end

    def index
        @items = Item.paginate(page: params[:page])
    end
    private
    	def item_params
			params.require(:item).permit(:item_amount, :item_price, :item_name)
		end
end
