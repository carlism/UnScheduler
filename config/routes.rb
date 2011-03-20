Unscheduler::Application.routes.draw do
  devise_for :users

  resources :events do
    resources :event_dates
  end
  resources :roles
  resources :rooms
  resources :time_slots
  resources :presentations

  root :to => "events#index"

  match 'events/:event_id/event_dates/:id', :to => 'event_dates#swap', :via => 'post'
end
