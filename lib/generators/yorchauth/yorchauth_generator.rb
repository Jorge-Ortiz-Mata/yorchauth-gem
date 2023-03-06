require_relative './actions/user_methods'
require_relative './actions/profile_methods'

class YorchauthGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def action_generator
    case file_name
    when 'user'
      user_authentication
    when 'profile'
      profile_association
    else
      puts 'You type a wrong paramater'
    end
  end

  private

  def user_authentication
    UserFiles.generate_user_files
  end

  def profile_association
    ProfileFiles.generate_profile_files
  end
end
