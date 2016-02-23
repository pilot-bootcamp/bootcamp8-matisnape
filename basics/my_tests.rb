require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test
  def test_initialization
  end

  def test_initialization_with_anonymous_author
  end

  def test_liking
  end

  def test_disliking
  end

  def test_points
  end

  def test_long_lines
  end

  def test_truncate
  end

  def test_truncate_when_limit_is_longer_then_body
  end

  def test_truncate_when_limit_is_same_as_body_length
  end

  def test_length
  end

  def test_votes
  end

  def test_contain
  end
end

class ArticlesFileSystemTest < Minitest::Test
  def test_saving
  end

  def test_loading
  end
end
