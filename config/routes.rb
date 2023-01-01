Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth',controllers:{
    sessions: 'sessions'
  }
  scope format: 'json' do # json形式のリクエストに対応
    resources :posts
  end
end
