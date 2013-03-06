ComparisonPortalApiPrototype::Application.routes.draw do

  get '/api/users' => 'api#get_users'
  post '/api/users' => 'api#post_users'
  put '/api/users' => 'api#put_users'
  delete '/api/users' => 'api#delete_users'


  get '/api/carts' => 'api#get_carts'
  post '/api/carts' => 'api#post_carts'
  put '/api/carts' => 'api#put_carts'
  delete '/api/carts' => 'api#delete_carts'

  get '/api/providers' => 'api#get_providers'
  post '/api/providers' => 'api#post_providers'
  put '/api/providers' => 'api#put_providers'
  delete '/api/providers' => 'api#delete_providers'

  get '/api' => 'api#root'
  root :to => 'api#root'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
