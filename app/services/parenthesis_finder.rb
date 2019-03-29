class ParenthesisFinder
  attr_reader :title
  def initialize title
    @title = title
  end

  def call
    parens = get_parenthesis
    new_title = add_parens parens
  end

  private
  def get_parenthesis
    parens = ActiveSupport::OrderedHash.new
    title.each_char.with_index do |char, idx|
      ["(", ")", "{", "}", "[", "]"].each do |symbol|
        parens[idx] = symbol if char == symbol
      end
    end
    parens
  end

  def add_parens parens
    left = []
    while parens.length
      object = parens.shift&.last
      break if object.nil?
      object = parenthesis[object]
      if parens.reject!{|_,v| v == object}.nil?
        left << object
      end
    end
    assign_parens_to_title left
  end

  def assign_parens_to_title left
    left.each do |char|
      title << char
    end
    title
  end

  def parenthesis
    { "(" => ")",
      ")" => "(",
      "{" => "}",
      "}" => "{",
      "[" => "]",
      "]" => "[" }
  end
end
