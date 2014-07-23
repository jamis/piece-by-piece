Rails.application.routes.draw do
  root 'landing#show'

  get "/names/parse", to: "name_service#parse", as: :parse_names
end
