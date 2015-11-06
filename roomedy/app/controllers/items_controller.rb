class ItemsController < ApplicationController

    #before_action :logged_in_user
    #before_action :correct_user

    
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
    
    def edit
        @item = Item.find(params[:id])
    end

    def update
         @item = Item.find(params[:id])
         if @item.update_attributes(item_params)
            flash[:success] = "Item successfully updated"
            redirect_to items_path
         else
            render 'edit'
         end
    end
    
    def destroy
        @item.destroy
        flash[:success] = "Item Deleted"
        redirect_to items_path
    end
    
    private
    	def item_params
			params.require(:item).permit(:item_amount, :item_price, :item_name)
		end
		
		def correct_user
		    @item = current_user.items.find_by(id: params[:id])
		    if @item.nil?
              flash[:danger] = "You are not allowed to perform that task on that item."
              redirect_to items_path
            end
	    end
end
