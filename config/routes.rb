Refinery::Core::Engine.routes.draw do
  # Frontend routes
  namespace :workflows do

    resources :workflows, :path => '', :only => [:index, :new, :create] do
      collection do
        get :thank_you
      end
    end
  end

  # Admin routes
  namespace :workflows, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}" do
      resources :workflows do 
  end

      scope :path => 'workflows' do
        resources :settings, :only => [:edit, :update]
      end
    end
  end
end

