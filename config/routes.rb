SentimentAnalysis::Application.routes.draw do
  get "opinions/create"

  resources :stop_words

  resources :internet_slang_words

  root :to => "entities#index"
  
  resources :entities do
    resources :opinions
  end
  
  match ":controller(/:action(/:id(.:format)))"
end
