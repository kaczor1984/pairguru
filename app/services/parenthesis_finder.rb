class ParenthesisFinder
  attr_reader :title
  def initialize title
    @title = title
  end

  def call
    parens = get_parenthesis
    return "two parens" if parens.key("(") == (parens.key(")")||0)-1 ||
                           parens.key("[") == (parens.key("]")||0)-1 ||
                           parens.key("{") == (parens.key("}")||0)-1
    new_title = add_parens parens
  end

  def brackets
    title_copy = title.dup
    call.remove(title_copy)
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
      object = parens.shift
      position, object = object&.first, object&.last
      break if object.nil?
      object = parenthesis[object]
      first, result = true, false
      if parens.reject! do |k,v|
            first = false if result
            result = v.in?(["(","[","{"]) ?
              (position > k && v == object) : (position < k && v == object)
            result && first
          end.nil?
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
