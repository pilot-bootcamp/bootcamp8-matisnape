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
    !!body.index(phrase)
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

  def initialize(dirname = '/')
    @dirname = dirname
    load
  end

  def load
    @articles = ArticlesFileSystem.new(@dirname).load
  end

  def save
    ArticlesFileSystem.new(@dirname).save(@articles)
  end

  def new_article(title, body, author)
    @articles << Article.new(title, body, author)
  end
end
