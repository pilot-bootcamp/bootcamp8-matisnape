require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test

  def test_initialization
    timebefore = Time.now
    @article = Article.new("title", "body", "author")
    timeafter = Time.now
    assert_equal "title", @article.title
    assert_equal "body", @article.body
    assert_equal "author", @article.author
    assert timebefore <= @article.created_at
    assert timeafter >= @article.created_at
    assert_equal 0, @article.likes
    assert_equal 0, @article.dislikes
  end

  def test_initialization_with_anonymous_author
    @article = Article.new("title", "body")
    assert_equal "title", @article.title
    assert_equal "body", @article.body
    assert_nil @article.author
  end

  def test_liking
    @article = Article.new("title", "body")
    @article.like!
    assert_equal 1, @article.likes
  end

  def test_disliking
    @article = Article.new("title", "body")
    @article.dislike!
    assert_equal 1, @article.dislikes
  end

  def test_points
    @article = Article.new("title", "body")
    assert_equal @article.likes - @article.dislikes, @article.points
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
