class YorchauthGenerator < Rails::Generators::NamedBase
  # desc 'You can pass several options such as user, profile and more. You can see more about it in the official documentation'
  source_root File.expand_path('templates', __dir__)
  class_option :module, type: :string

  def action_generator
    if @name.downcase.eql? 'user'
      user_authentication
    else
      p 'Wrong parameter. Try with: rails g yorchauth user'
    end
  end

  private

  def user_authentication
    user_controllers_files # Copy the controllers files.
    copy_file './app/mailers/user_mailer.rb', 'app/mailers/user_mailer.rb' # Copy the user_mailer.rb file.
    copy_file './app/models/user.rb', 'app/models/user.rb' # Copy the user model file.
    copy_file "./db/migrate/users_table.rb", "db/migrate/#{Time.now.strftime('%Y%m%d%H%M%S')}_create_users.rb"
    create_file ".env", "MI_KEYS"
    user_views_files
    user_injecting_code
    adding_gems
  end

  def user_controllers_files
    copy_file './app/controllers/authenticate_controller.rb', 'app/controllers/authenticate_controller.rb' # Copy the authenticate controller.
    copy_file './app/controllers/sessions_controller.rb', 'app/controllers/sessions_controller.rb' # Copy the sessions controller.
    copy_file './app/controllers/users_controller.rb', 'app/controllers/users_controller.rb' # Copy the users folder.
  end

  def user_views_files
    directory './app/views/sessions', 'app/views/sessions' # Copy the sessions directory.
    directory './app/views/shared', 'app/views/shared' # Copy the shared directory.
    directory './app/views/user_mailer', 'app/views/user_mailer' # Copy the user_mailer directory.
    directory './app/views/users', 'app/views/users' # Copy the users directory.
  end

  def user_injecting_code
    injecting_to_layouts_application
    injecting_to_config_routes
    injecting_to_config_development
  end

  def injecting_to_layouts_application
    inject_into_file 'app/views/layouts/application.html.erb', after: '<body>' do
      <<-'RUBY'

    <%= render 'shared/navbar' %>
    <p><%= notice if notice %></p>
      RUBY
    end
  end

  def injecting_to_config_development
    inject_into_file 'config/environments/development.rb', after: 'config.action_mailer.raise_delivery_errors = false' do
      <<-'RUBY'

  # Action Mailer configuration with Sendgrid
  # Remove this line -> config.action_mailer.raise_delivery_errors = false; line 40.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name: 'apikey',
    password: ENV['SENDGRID_API_KEY'],
    domain: 'localhost:3000',
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
      RUBY
    end
  end

  def injecting_to_config_routes
    inject_into_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
      <<-'RUBY'

  # User Authentication routes.
  resources :users, only: %i[create]
  get '/signup', to: 'users#new'
  get '/users/:token_id', to: 'users#show', as: 'user'
  get '/users/edit/:token_id', to: 'users#edit', as: 'edit_user'
  patch '/users/edit/:token_id', to: 'users#update', as: 'update_user'
  delete '/users/destroy/:token_id', to: 'users#destroy', as: 'destroy_user'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#logout'
  get '/email/confirmation/:token_id', to: 'users#confirm_account', as: 'confirm_user_account'
      RUBY
    end
  end

  def adding_gems
    gem "bcrypt", "~> 3.1.7"

    gem_group :development, :test do
      gem "dotenv-rails"
    end
  end
end
