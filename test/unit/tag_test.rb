# encoding: utf-8
require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def test_tag_names_are_extractable_from_string
    tag_names = Tag.extract("aaa, bbb,aaa,ccc,  ddd\t\taaa")
    assert_equal [ 'aaa', 'bbb', 'ccc', 'ddd aaa' ], tag_names
  end


  def test_tag_names_can_contain_special_characters
    tag_names = Tag.extract("Demande d'aide, Développement")
    assert_equal [ "Demande d'aide", 'Développement' ], tag_names
  end
end
