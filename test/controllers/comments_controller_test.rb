require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post comments_url, params: { comment: { author_id: @comment.author_id, body: @comment.body } }
    end

    assert_redirected_to comment_url(Comment.last)
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
