class YorchauthGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def action_generator
    sayHi
  end

  private

  def sayHi
    puts 'Hello World'
  end
end
