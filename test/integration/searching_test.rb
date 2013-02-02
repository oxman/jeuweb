require 'integration_test_helper'

class SearchingTest < ActionDispatch::IntegrationTest
  def test_filtering_by_tag
    topic_1 = FactoryGirl.create(:topic); topic_1.tag_with(%w( Foo Bar ))
    topic_2 = FactoryGirl.create(:topic); topic_2.tag_with(%w( Foo ))
    topic_3 = FactoryGirl.create(:topic); topic_3.tag_with(%w( Bar ))

    visit(topics_search_path(tags: 'Foo'))

    assert has_content?(topic_1.title),    'Topic 1 has Foo tags and should be found'
    assert has_content?(topic_2.title),    'Topic 2 has Foo tag and should be found'
    assert has_no_content?(topic_3.title), 'Topic 3 has only Bar tag and should not be found'
  end


  def test_tags_can_be_added_or_removed_by_clicking_tag_names
    Tag.create(name: 'Foo')
    bar     = Tag.create(name: 'Bar')
    topic_1 = FactoryGirl.create(:topic); topic_1.tag_with(%w( Foo Bar ))
    topic_2 = FactoryGirl.create(:topic); topic_2.tag_with(%w( Foo ))
    topic_3 = FactoryGirl.create(:topic); topic_3.tag_with(%w( Bar ))

    visit(topics_search_path(tags: 'Foo'))

    assert has_css?('#available_tags .tag', count: 2)
    assert has_css?('#available_tags .active', count: 1)

    find("#available_tags .tag-#{bar.id}").click # Add Bar tag.

    assert has_css?('#available_tags .active', count: 2)
    assert has_content?(topic_1.title),    'Topic 1 has Foo and Bar tags and should be found'
    assert has_no_content?(topic_2.title), 'Topic 2 has only Foo tag and should not be found'
    assert has_no_content?(topic_3.title), 'Topic 3 has only Bar tag and should not be found'
  end
end
