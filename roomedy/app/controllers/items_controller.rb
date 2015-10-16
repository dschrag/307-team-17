class ItemsController < ApplicationController
    def show
        @item = Item.find(params[:id])
    end
    
    def new
        @item = Item.new
    end
    
    def create
        @item = Item.new(item_params)
        if @item.save
            if current_user.save(validate: false)
               flash[:success] = "Item created!"
            else
               flash[:notice] = "Unable to create item"
            end
            redirect_to items_path
        else
            render 'new'
        end
    end
    private
    	def item_params
			params.require(:item).permit(:item_amount, :item_price, :item_name)
		end
end
