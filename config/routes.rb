SAE::Application.routes.draw do

  devise_for :pessoas

  resources :paciente do
    resources :registro_de_emergencia
  end
  
  match "answer_paciente" => "registro_de_emergencia#answer", :as => 'answer_paciente'
  
  authenticated :pessoa do
    root :to => 'chamada#inicia'
  end
  
  match "chamada/enviarMensagem" => "chamada#enviarMensagem", :via => :put
  match "chamada/mensagem/:id" => "chamada#mensagem", :as => 'chamada_mensagem'
  match "chamada/:id" => "chamada#index", :as => 'chamada'
  match "chamada/esperaAtendimento/:id" => "chamada#esperaAtendimento", :as => 'esperaAtendimento'
  match "chamada/esperaConsulta/:id" => "chamada#esperaConsulta", :as => 'esperaConsulta'
  match "chamada/esperaPaciente/:id" => "chamada#esperaPaciente", :as => 'esperaPaciente'
#  match "chamada/inicia" => "chamada#inicia", :as => 'inicia_chamada'
  
  match "pesquisa" => "pesquisa#index", :via => :get
  match "pesquisa/pacientes" => "pesquisa#search", :via => :get, :as => 'pesquisa_search'
  
  
  match "selecionar_veiculo" => "selecionar_veiculo#index"
  
  match "show_prontuario" => "show_prontuario#show", :via => :get, :as => 'show_prontuario'
  match "index_prontuario" => "show_prontuario#index", :via => :get, :as => 'index_prontuario'
  
  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  #root :to => 'devise/sessions#new'
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
