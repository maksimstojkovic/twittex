require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:user1)
  end

  test "should retrieve follows received" do
    assert_equal @user.follows_received.length, 2
    assert_includes @user.follows_received, follows(:pending_follower_request)
    assert_includes @user.follows_received, follows(:accepted_follower_request)
  end

  test "should retrieve pending follower request" do
    assert_equal @user.pending_follower_requests.length, 1
    assert_includes @user.pending_follower_requests, follows(:pending_follower_request)
  end

  test "should retrieve accepted follower request" do
    assert_equal @user.accepted_follower_requests.length, 1
    assert_includes @user.accepted_follower_requests, follows(:accepted_follower_request)
  end

  test "should retrieve pending followers" do
    assert_equal @user.pending_followers.length, 1
    assert_includes @user.pending_followers, users(:user2)
  end

  test "should retrieve followers" do
    assert_equal @user.followers.length, 1
    assert_includes @user.followers, users(:user3)
  end

  test "should retrieve follows sent" do
    assert_equal @user.follows_sent.length, 2
    assert_includes @user.follows_sent, follows(:pending_following_request)
    assert_includes @user.follows_sent, follows(:accepted_following_request)
  end

  test "should retrieve pending following requests" do
    assert_equal @user.pending_following_requests.length, 1
    assert_includes @user.pending_following_requests, follows(:pending_following_request)
  end

  test "should retrieve accepted following requests" do
    assert_equal @user.accepted_following_requests.length, 1
    assert_includes @user.accepted_following_requests, follows(:accepted_following_request)
  end

  test "should retrieve pending followings" do
    assert_equal @user.pending_followings.length, 1
    assert_includes @user.pending_followings, users(:user2)
  end

  test "should retrieve followings" do
    assert_equal @user.followings.length, 1
    assert_includes @user.followings, users(:user3)
  end
end
