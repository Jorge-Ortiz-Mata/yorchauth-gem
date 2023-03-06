class YorchauthGenerator < Rails::Generators::NamedBase
  # desc 'You can pass several options such as user, profile and more. You can see more about it in the official documentation'
  source_root File.expand_path("templates", __dir__)
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
    directory './app/controllers/', 'app/controllers/' # Copy the controllers folder.
    copy_file './app/mailers/user_mailer.rb', 'app/mailers/user_mailer.rb' # Copy the user_mailer.rb file.
  end
end
