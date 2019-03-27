class MovieApi < Flexirest::Base
  base_url "https://pairguru-api.herokuapp.com/api/v1/"

  get :find, "/movies/:id"
end
