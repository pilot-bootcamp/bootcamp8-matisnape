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
        File.write(file_name(a), article_content(a))
      end
    end
  end

  def file_name(a)
    a.title.downcase.gsub(' ', '_') + '.article'
  end

  def article_content(a)
    [a.author, a.likes, a.dislikes, a.body].join('||')
  end
end
