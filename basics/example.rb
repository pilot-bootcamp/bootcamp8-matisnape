class Article
  attr_reader :title, :body, :author, :created_at
  attr_accessor :likes, :dislikes

  def initialize(title, body, author, created_at, likes, dislikes)
    @title = title
    @body = body
    @author = author
    @created_at = created_at
    @likes = likes
    @dislikes = dislikes
  end
end
