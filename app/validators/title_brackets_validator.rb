class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    unless ParenthesisFinder.new(record.title).brackets.empty?
      record.errors[:title] << 'The title contains some unclosed brackets'
    end
  end
end
