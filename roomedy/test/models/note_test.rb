require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  def setup
    @user = users(:derek)
    @note = @user.notes.build(content: "This is a note.")
  end

  test "should be valid" do
    assert @note.valid?
  end

  test "notes need user id" do
    @note.user_id = nil
    assert_not @note.valid?
  end

  test "notes need to have content" do
    @note.content = ""
    assert_not @note.valid?
  end

  test "notes are retreived with most recent notes first" do
    assert_equal notes(:most_recent), Note.first
  end

end
