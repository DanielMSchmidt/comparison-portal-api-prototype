ComparisonPortalApiPrototype::Application.routes.draw do

  get '/users' => 'api#get_users'
  post '/users' => 'api#post_users'
  put '/users' => 'api#put_users'
  delete '/users' => 'api#delete_users'


  get '/carts' => 'api#get_carts'
  post '/carts' => 'api#post_carts'
  put '/carts' => 'api#put_carts'
  delete '/carts' => 'api#delete_carts'

  get '/providers' => 'api#get_providers'
  post '/providers' => 'api#post_providers'
  put '/providers' => 'api#put_providers'
  delete '/providers' => 'api#delete_providers'


  root :to => 'api#root'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
