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
    @likes - @dislikes
  end

  def votes
    @likes + @dislikes
  end

  def long_lines
    lines = @body.lines.to_a
    lines.select! { |line| line.length > 80 }
  end

  def length
    @body.length
  end

  def truncate(limit)
    @body.length > limit ? "#{@body[0, limit-3]}" + "..." : @body
  end

  def contain?(phrase)
    if phrase.is_a? String
      @body.include? phrase
    elsif phrase.is_a? Regexp
      phrase.match(@body) ? true : false
    end
  end
end
