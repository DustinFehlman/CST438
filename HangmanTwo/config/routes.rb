Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'games/play' => 'games#play'
  post 'games/play' => 'games/#play'
end
