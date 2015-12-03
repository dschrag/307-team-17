class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_note, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @note.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to note_path(@note)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to note_path(@note)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to note_path(@note)
  end

  private

    def comment_params
      params.require(:comment).permit(:reply)
    end

    def find_note
      @note = Note.find(params[:note_id])
    end

    def find_comment
      @comment = @note.comments.find(params[:id])
    end

end
