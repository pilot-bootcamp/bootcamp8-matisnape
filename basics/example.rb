class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes

  def initialize(title, body, author = nil)
    @title = title
    @body = body
    @author = author
    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end

  def like!
    @likes += 1
  end

  def dislike!
    @dislikes += 1
  end

  def points
    likes - dislikes
  end

  def votes
    likes + dislikes
  end

  def long_lines
    body.lines.select { |line| line.length > 80 }
  end

  def length
    body.length
  end

  def truncate(limit)
    body.length > limit ? "#{@body[0...limit-3]}..." : body
  end

  def contain?(phrase)
    body.index(phrase) ? true : false
  end
end

class ArticlesFileSystem
  def initialize(dirname)
    @dirname = dirname
  end

  def save(articles)
    Dir.chdir(@dirname) do
      articles.each do |a|
        File.write(create_file_name(a), create_article_content(a))
      end
    end
  end

  def create_file_name(a)
    a.title.downcase.gsub(' ', '_') + '.article'
  end

  def create_article_content(a)
    [a.author, a.likes, a.dislikes, a.body].join('||')
  end

  def load
    arr = []
    Dir.chdir(@dirname) do
      Dir.glob('*.article').each do |file|
        arr << revert_file_contents(file)
      end
    end
    arr
  end

  def revert_file_contents(file)
    author, likes, dislikes, body = File.read(file).split('||')
    title = file.split('.').first.gsub('_', ' ').capitalize
    article = Article.new(title, body, author)
    article.likes = likes.to_i
    article.dislikes = dislikes.to_i
    article
  end
end

class WebPage
  attr_reader :articles
  attr_reader :filesystem

  def initialize(dirname = '/')
    @dirname = dirname
    @filesystem = ArticlesFileSystem.new(@dirname)
    load
  end

  def load
    @articles = filesystem.load
  end

  def save
    filesystem.save(@articles)
  end

  def new_article(title, body, author)
    @articles << Article.new(title, body, author)
  end

  def longest_articles
    @articles.sort_by { |article| article.body.length }.reverse
  end

  def best_articles
    worst_articles.reverse
  end

  def worst_articles
    @articles.sort_by(&:points)
  end

  def best_article
    raise WebPage::NoArticlesFound if best_articles.first.nil?
    best_articles.first
  end

  def worst_article
    raise WebPage::NoArticlesFound if worst_articles.first.nil?
    worst_articles.first
  end

  def most_controversial_articles
    @articles.sort_by(&:votes).reverse
  end

  def votes
    votes = 0
    @articles.each do |a|
      votes += a.votes
    end
    votes
  end

  def authors
    @articles.map(&:author).uniq
  end

  def authors_statistics
    @articles.map(&:author).each_with_object(Hash.new(0)) do |author, authors_statistics|
      authors_statistics[author] += 1
    end
  end

  def best_author
    authors_statistics.max_by{ |author, count| count }[0]
  end

  def search(query)
    @articles.select { |article| article.contain? query }
  end

  class NoArticlesFound < StandardError
  end
end
