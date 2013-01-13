require 'integration_test_helper'

class TopicsTest < ActionDispatch::IntegrationTest
  def test_guest_user_cant_create_topic
    visit('/')
    assert has_no_selector?('.create_topic'), 'Guest user should not see any link to create a topic'
    assert_raise(CanCan::AccessDenied) { visit('/topics/new') }
  end


  def test_signed_in_user_can_create_topic
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    assert has_selector?('.create_topic'), 'Signed in user should see a link to create a topic'
    find('.create_topic').click
    fill_in 'topic[title]', with: 'Some title'
    fill_in 'topic[content]', with: 'Some content'
    find('[type=submit]').click
    assert has_content?('Some title')
    assert has_content?('Some content')
  end
end
