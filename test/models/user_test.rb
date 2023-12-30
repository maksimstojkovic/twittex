require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should retrieve follows received" do
    assert_equal 2, @user.follows_received.length
    assert_includes @user.follows_received, follows(:follower_one)
    assert_includes @user.follows_received, follows(:follower_two)
  end

  test "should retrieve followers" do
    assert_equal 2, @user.followers.length
    assert_includes @user.followers, users(:two)
    assert_includes @user.followers, users(:three)
  end

  test "should retrieve follows sent" do
    assert_equal @user.follows_sent.length, 2
    assert_includes @user.follows_sent, follows(:following_one)
    assert_includes @user.follows_sent, follows(:following_two)
  end

  test "should retrieve followings" do
    assert_equal @user.followings.length, 2
    assert_includes @user.followings, users(:two)
    assert_includes @user.followings, users(:three)
  end
end
