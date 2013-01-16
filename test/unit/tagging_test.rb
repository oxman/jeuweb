require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  def test_topic_can_be_tagged
    topic = Topic.create
    topic.tag_with(%w( foo foo bar ))
    assert_equal %w( foo bar ), Tag.pluck(:name)
    assert_equal 2, Tagging.count
  end


  def test_topic_old_tags_are_removed_when_tagged_again
    topic = Topic.create
    topic.tag_with(%w( foo bar ))
    topic.reload
    topic.tag_with(%w( bar ))
    assert_equal %w( foo bar ), Tag.pluck(:name)
    assert_equal 1, Tagging.count
  end
end
