require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test

  def test_initialization
    timebefore = Time.now
    @article = Article.new('title', 'body', 'author')
    timeafter = Time.now
    assert_equal 'title', @article.title
    assert_equal 'body', @article.body
    assert_equal 'author', @article.author
    assert timebefore <= @article.created_at
    assert timeafter >= @article.created_at
    assert_equal 0, @article.likes
    assert_equal 0, @article.dislikes
  end

  def test_initialization_with_anonymous_author
    @article = Article.new('title', 'body')
    assert_equal 'title', @article.title
    assert_equal 'body', @article.body
    assert_nil @article.author
  end

  def test_liking
    @article = Article.new('title', 'body')
    @article.like!
    assert_equal 1, @article.likes
  end

  def test_disliking
    @article = Article.new('title', 'body')
    @article.dislike!
    assert_equal 1, @article.dislikes
  end

  def test_points
    @article = Article.new('title', 'body')
    assert_equal @article.likes - @article.dislikes, @article.points
  end

  def test_long_lines
    @article_80 = Article.new('title', 'a'*80)
    assert_empty @article_80.long_lines
    @article_81 = Article.new('title', 'a'*81)
    assert_equal 1, @article_81.long_lines.count
  end

  def test_truncate
    @article = Article.new('title', 'a'*6)
    assert_equal 'aa...', @article.truncate(5)
  end

  def test_truncate_when_limit_is_longer_then_body
    @article = Article.new('title', 'a'*4)
    assert_equal 'a'*4, @article.truncate(5)
  end

  def test_truncate_when_limit_is_same_as_body_length
    @article = Article.new('title', 'a'*5)
    assert_equal 'a'*5, @article.truncate(5)
  end

  def test_length
    @article = Article.new('title', 'body')
    assert_equal 4, @article.length
  end

  def test_votes
    @article = Article.new('title', 'body')
    assert_equal @article.likes + @article.dislikes, @article.votes
  end

  def test_contain
    @article = Article.new('title', 'body')
    assert_equal true, @article.contain?('bo')
    assert_equal false, @article.contain?('asdsa')
    assert_equal true, @article.contain?('dy')
  end
end

class ArticlesFileSystemTest < Minitest::Test
  def test_saving
    require 'pathname'
    @article = Article.new('title', 'body', 'author')
    dirname = Dir.mktmpdir
    path = Pathname.new(dirname)
    @filesystem = ArticlesFileSystem.new(dirname)
    @filesystem.save([@article])
    assert_equal 1, @filesystem.load.count
    assert_includes path.children.map(&:basename).map(&:to_s), 'title.article'
    assert_equal 'body', @filesystem.load.first.body
  end

  def test_loading
  end
end
