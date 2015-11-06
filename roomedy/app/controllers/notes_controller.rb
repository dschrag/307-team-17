class NotesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
  	@note = Note.new
    @note.permissions.build
  end

  def create
  	@note = current_user.notes.build(note_params)
  	if @note.save
      @perm_user = @note.permissions.create(user_id: current_user.id, level: 0)
  	  flash[:success] = "Note Created"
      redirect_to notes_path
  	else
  	  render 'new'
  	 end
  end

  def destroy
    @note.destroy
    flash[:success] = "Note deleted"
    redirect_to notes_path
  end

  def index
  	@notes = Note.paginate(page: params[:page])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(note_params)
      flash[:success] = "Note updated"
      redirect_to notes_path
    else
      render 'edit'
    end
  end

  private

    def note_params
      params.require(:note).permit(:content, permissions_attributes: [:id, :user_id, :level])
    end

    def correct_user
      @note = current_user.notes.find_by(id: params[:id])
      if @note.nil?
        flash[:danger] = "You are not allowed to perform that task on that note."
        redirect_to notes_path
      end
    end


end
