class NotesController < ApplicationController
  before_action :logged_in_user

  def new
  	@note = Note.new
  end

  def create
  	@note = current_user.notes.build(note_params)
  	if @note.save
  	  flash[:success] = "Note Created"
  	  redirect_to notes_path
  	else
  	  render 'new'
  	 end
  end

  def destroy
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
      params.require(:note).permit(:content)
    end
end
