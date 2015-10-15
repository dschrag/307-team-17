require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  def setup
    @user = users(:derek)
    @note = Note.new(content: "This is a note message", user_id: @user.id)
  end

  test "should be valid" do
    assert @note.valid?
  end

  test "notes need user id" do
    @note.user_id = nil
    assert_not @note.valid?
  end
end
