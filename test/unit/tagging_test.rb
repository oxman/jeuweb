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


  def test_filtering_topics_by_tags
    topic_1 = FactoryGirl.create(:topic); topic_1.tag_with(%w( foo bar ))
    topic_2 = FactoryGirl.create(:topic); topic_2.tag_with(%w( foo ))
    topic_3 = FactoryGirl.create(:topic); topic_3.tag_with(%w( bar ))

    assert_equal [ topic_1, topic_3 ], Topic.with_tags(%w( bar )).order(:id)
    assert_equal [ topic_1, topic_2 ], Topic.with_tags(%w( foo )).order(:id)
    assert_equal [ topic_1 ], Topic.with_tags(%w( foo bar )).order(:id)
  end
end
