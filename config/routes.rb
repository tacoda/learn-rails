Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles do
    resources :comments
  end

  # HTTP Verb	Path	Controller#Action	Used for
  # GET	/photos	photos#index	display a list of all photos
  # GET	/photos/new	photos#new	return an HTML form for creating a new photo
  # POST	/photos	photos#create	create a new photo
  # GET	/photos/:id	photos#show	display a specific photo
  # GET	/photos/:id/edit	photos#edit	return an HTML form for editing a photo
  # PATCH/PUT	/photos/:id	photos#update	update a specific photo
  # DELETE	/photos/:id	photos#destroy	delete a specific photo
  #
  # resources :photos


  # These work the same way
  #
  # resources :photos, :books, :videos
  #
  # resources :photos
  # resources :books
  # resources :videos

  # Nested resources
  namespace :admin do
    resources :articles, :comments
  end

  resources :clients

  # Resources should never be nested more than 1 level deep.

  # Shallow nesting
  #
  # resources :articles do
  #   resources :comments, only: [:index, :new, :create]
  # end
  # resources :comments, only: [:show, :edit, :update, :destroy]

  # Same as
  #
  # resources :articles do
  #   resources :comments, shallow: true
  # end

  root 'welcome#index'
end
