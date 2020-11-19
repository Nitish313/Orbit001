require 'test_helper'

class SnapshotsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @snapshot = snapshots(:project001)
  end
  
  test "should redirect create when user not logged in" do
    assert_no_difference 'Snapshot.count' do
      post snapshots_path, params: {snapshot: {content: "Test content"}}
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Snapshot.count' do
      delete snapshot_path(@snapshot)
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong snapshot" do
    @user = users(:tony)
    @other_user = users(:jane)
    log_in_as(@other_user)
    assert_no_difference 'Snapshot.count' do
      delete snapshot_path(@snapshot)
    end
    assert_redirected_to root_url
  end
end
