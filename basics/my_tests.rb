require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test

  def setup
    @article = Article.new('title', 'bodybo')
  end

  def test_initialization
    timebefore = Time.now
    @article_author = Article.new('title', 'body', 'author')
    timeafter = Time.now
    assert_equal 'title', @article_author.title
    assert_equal 'body', @article_author.body
    assert_equal 'author', @article_author.author
    assert timebefore <= @article_author.created_at
    assert timeafter >= @article_author.created_at
    assert_equal 0, @article_author.likes
    assert_equal 0, @article_author.dislikes
  end

  def test_initialization_with_anonymous_author
    assert_equal 'title', @article.title
    assert_equal 'bodybo', @article.body
    assert_nil @article.author
  end

  def test_liking
    @article.like!
    assert_equal 1, @article.likes
  end

  def test_disliking
    @article.dislike!
    assert_equal 1, @article.dislikes
  end

  def test_points
    assert_equal @article.likes - @article.dislikes, @article.points
  end

  def test_long_lines
    @article_80 = Article.new('title', 'a'*80)
    assert_empty @article_80.long_lines
    @article_81 = Article.new('title', 'a'*81)
    assert_equal 1, @article_81.long_lines.count
  end

  def test_truncate
    assert_equal 'bo...', @article.truncate(5)
  end

  def test_truncate_when_limit_is_longer_then_body
    assert_equal 'bodybo', @article.truncate(7)
  end

  def test_truncate_when_limit_is_same_as_body_length
    assert_equal 'bodybo', @article.truncate(6)
  end

  def test_length
    assert_equal 6, @article.length
  end

  def test_votes
    assert_equal @article.likes + @article.dislikes, @article.votes
  end

  def test_contain
    assert_equal true, @article.contain?('bo')
    assert_equal false, @article.contain?('asdsa')
    assert_equal true, @article.contain?('dy')
  end
end

class ArticlesFileSystemTest < Minitest::Test

  def setup
    @dirname = Dir.mktmpdir
    @article = Article.new('Title', 'body', 'author')
    @filesystem = ArticlesFileSystem.new(@dirname)
  end

  def teardown
    FileUtils.rm_rf @dirname
  end

  def test_saving
    require 'pathname'
    path = Pathname.new(@dirname)
    @filesystem.save([@article])
    assert_equal 1, @filesystem.load.count
    assert_includes path.children.map(&:basename).map(&:to_s), 'title.article'
    assert_equal 'body', @filesystem.load.first.body
  end

  def test_loading
    Dir.chdir(@dirname) do
      File.write(@filesystem.create_file_name(@article), @filesystem.create_article_content(@article))
    end
    assert_equal @article.title, @filesystem.load.first.title
    assert_equal @article.body, @filesystem.load.first.body
    assert_equal @article.author, @filesystem.load.first.author
    assert_equal @article.likes, @filesystem.load.first.likes
    assert_equal @article.dislikes, @filesystem.load.first.dislikes
  end
end
