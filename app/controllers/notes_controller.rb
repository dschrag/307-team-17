class NotesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
  	@note = Note.new
    @note.permissions.build
  end

  def create
  	@note = current_user.notes.build(note_params)
    @note.house_id = current_user.relationship.house_id
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
    h = House.find(current_user.relationship.house_id)
  	@notes = h.notes.paginate(page: params[:page])
    @polls = h.polls

    @collect = @notes + @polls
    puts @collect
    @collect = (@collect.sort_by &:created_at).reverse
    puts @collect
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  def edit
    @note = Note.find(params[:id])
  end

  def show
    @notes = Note.paginate(page: params[:page])
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    permparams = (params[:note][:permission].permit!)
    permparams.each_key do |key|
      perm = Permission.find(key)
      perm.level = permparams[key][:level]
      perm.save
    end

    if @note.update_attributes(note_params)
      flash[:success] = "Note updated"
      redirect_to notes_path
    else
      render 'edit'
    end
  end

  private

    def note_params
      params.require(:note).permit(:id, :content, :lastEditedBy, :title,
      permissions_attributes: [:id, :user_id, :level])
    end

    def correct_user
      @note = Note.find_by(id: params[:id])
      if @note.nil?
        flash[:danger] = "You are not allowed to perform that task on that note."
        redirect_to notes_path
      end
    end

end
