require 'integration_test_helper'

class SearchingTest < ActionDispatch::IntegrationTest
  def test_filtering_by_tag
    topic_1 = FactoryGirl.create(:topic); topic_1.tag_with(%w( foo bar ))
    topic_2 = FactoryGirl.create(:topic); topic_2.tag_with(%w( foo ))
    topic_3 = FactoryGirl.create(:topic); topic_3.tag_with(%w( bar ))

    visit(topics_search_path(tags: 'foo'))

    assert has_content?(topic_1.title),    'Topic 1 has foo tags and should be found'
    assert has_content?(topic_2.title),    'Topic 2 has foo tag and should be found'
    assert has_no_content?(topic_3.title), 'Topic 3 has only bar tag and should not be found'
  end


  def test_tags_can_be_added_or_removed_by_clicking_tag_names
    foo     = Tag.create(name: 'foo')
    bar     = Tag.create(name: 'bar')
    topic_1 = FactoryGirl.create(:topic); topic_1.tag_with(%w( foo bar ))
    topic_2 = FactoryGirl.create(:topic); topic_2.tag_with(%w( foo ))
    topic_3 = FactoryGirl.create(:topic); topic_3.tag_with(%w( bar ))

    visit(topics_search_path(tags: 'foo'))

    assert has_css?('#available_tags .tag', count: 2)
    assert has_css?('#available_tags .active', count: 1)

    find("#available_tags .tag-#{bar.id}").click # Add bar tag.

    assert has_css?('#available_tags .active', count: 2)
    assert has_content?(topic_1.title),    'Topic 1 has foo and bar tags and should be found'
    assert has_no_content?(topic_2.title), 'Topic 2 has only foo tag and should not be found'
    assert has_no_content?(topic_3.title), 'Topic 3 has only bar tag and should not be found'
  end
end
