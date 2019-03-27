class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def avatar
    "https://pairguru-api.herokuapp.com/#{online_content.data.attributes.poster}"
  end

  def rating
    online_content.data.attributes.rating
  end

  def plot
    online_content.data.attributes.plot
  end

  private
  def online_content
    @movie ||= MovieApi.find(object.title)
  end
end
