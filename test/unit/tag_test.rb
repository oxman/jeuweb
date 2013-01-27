# encoding: utf-8
require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def test_duplicate_names_are_removed
    tag_names = Tag.extract('Question Développement Question')
    assert_equal %w( Question Développement ), tag_names
  end


  def test_names_are_prettified
    tag_names = Tag.extract('qUeStIoN')
    assert_equal %w( Question ), tag_names
  end


  def test_names_are_extracted_with_commas
    tag_names = Tag.extract('Question,Développement')
    assert_equal %w( Question Développement ), tag_names
  end
end
