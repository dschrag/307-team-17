class PermissionsController < ApplicationController
  def edit
    @permission = Permission.find(params[:id])
  end

  def update
    @permission = Permission.find(params[:id])
    if @permission.update_attributes(permission_params)
      flash[:success] = "Permissions Updated"
    else
      render 'edit'
    end
  end

  private

    def note_params
      params.require(:permission).permit(:user_id, :level)
    end

end
