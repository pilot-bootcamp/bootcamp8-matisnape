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
    @filesystem = ArticlesFileSystem.new(@dirname)
  end

  def teardown
    FileUtils.rm_rf @dirname
  end

  def test_saving
    require 'pathname'
    @article1 = Article.new('Article1', 'body', 'author')
    path = Pathname.new(@dirname)
    @filesystem.save([@article1])
    assert_equal 1, @filesystem.load.count
    assert_includes path.children.map(&:basename).map(&:to_s), 'article1.article'
    assert_equal 'body', @filesystem.load.first.body
  end

  def test_loading
    File.write(@dirname + '/article_1.article', 'author||1||2||body')
    File.write(@dirname + '/article2.article', '||0||0||anks')
    File.write(@dirname + '/foobar', '||0||0||body')
    loaded_articles = @filesystem.load.sort_by(&:title)
    assert_equal ['Article 1', 'Article2'], loaded_articles.map(&:title)
    assert_equal ['author', ''], loaded_articles.map(&:author)
    assert_equal [1, 0], loaded_articles.map(&:likes)
    assert_equal [2, 0], loaded_articles.map(&:dislikes)
    assert_equal ['body', 'anks'], loaded_articles.map(&:body)
  end
end

class WebPageTest < Minitest::Test

  def setup
    @dirname = Dir.mktmpdir
    @page = WebPage.new(@dirname)

    @article1 = Article.new('title1', 'a'*15, 'author')
    @article1.likes = 1
    @article1.dislikes = 4
    @article2 = Article.new('title2', 'a'*10, 'author')
    @article2.likes = 3
    @article2.dislikes = 4
    @article3 = Article.new('title3', 'a'*20, 'author3')
    @article3.likes = 4
    @article3.dislikes = 0
  end

  def test_new_without_anything_to_load
    assert_empty @page.articles
  end

  def test_new_article
    size_before = @page.articles.count
    @page.new_article('title', 'body', 'author')
    assert_equal size_before + 1, @page.articles.count
  end

  def test_longest_articles
    @page.instance_variable_set(:@articles, [@article1, @article2, @article3])
    # ^ this is a walkaround if you don't have setter for @articles array
    assert_equal [@article3, @article1, @article2], @page.longest_articles
  end

  def test_best_articles
    @page.instance_variable_set(:@articles, [@article1, @article2, @article3])
    sorted_articles = @page.best_articles
    assert sorted_articles[0].points >= sorted_articles[1].points
    assert sorted_articles[1].points >= sorted_articles[2].points
  end

  def test_best_article
    @page.instance_variable_set(:@articles, [@article1, @article2, @article3])
    assert_equal @article3, @page.best_articles.first
  end

  def test_best_article_exception_when_no_articles_can_be_found
    assert_raises (WebPage::NoArticlesFound) { @page.best_article }
  end

  def test_worst_articles
    @page.instance_variable_set(:@articles, [@article1, @article2, @article3])
    sorted_articles = @page.worst_articles
    assert sorted_articles[0].points <= sorted_articles[1].points
    assert sorted_articles[1].points <= sorted_articles[2].points
  end

  def test_worst_article
    @page.instance_variable_set(:@articles, [@article1, @article2, @article3])
    assert_equal @article1, @page.worst_articles.first
  end

  def test_worst_article_exception_when_no_articles_can_be_found
    assert_raises (WebPage::NoArticlesFound) { @page.worst_article }
  end

  def test_most_controversial_articles
  end

  def test_votes
  end

  def test_authors
  end

  def test_authors_statistics
  end

  def test_best_author
  end

  def test_search
  end
end
