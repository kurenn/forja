# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║  Forja — Rails Application Template                                        ║
# ║                                                                            ║
# ║  Usage:                                                                    ║
# ║    rails new myapp -d postgresql --css=tailwind -m path/to/template.rb     ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

FORJA_ROOT = __dir__

def forja_read(relative_path)
  File.read(File.join(FORJA_ROOT, 'templates', relative_path))
end

def forja_say(message)
  say "🔨 #{message}", :cyan
end

def copy_template_directory(source_dir, target_dir)
  source_path = File.join(FORJA_ROOT, 'templates', source_dir)
  return unless Dir.exist?(source_path)

  Dir.glob("#{source_path}/**/*", File::FNM_DOTMATCH).each do |file|
    next if File.directory?(file)
    next if File.basename(file) == '.DS_Store'
    next if ['.', '..'].include?(File.basename(file))

    relative_path = file.sub("#{source_path}/", '')
    target_file = File.join(target_dir, relative_path)

    # Ensure directory exists
    FileUtils.mkdir_p(File.dirname(target_file))

    # Copy the file
    create_file target_file, File.read(file), force: true
  end
end

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 1. Gems
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Testing
gem_group :development, :test do
  gem 'rspec-rails', '~> 8.0'
  gem 'factory_bot_rails'
end

gem_group :test do
  gem 'shoulda-matchers', '~> 6.0'
end

# Authentication
gem 'devise'

# AI-assisted development
gem_group :development do
  gem 'claude-on-rails'
end

gem 'view_component'

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 2. Bundle
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

after_bundle do
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 3. Copy Component Library and Assets
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Forging component library from the Forja template...'
  copy_template_directory('app', 'app')

  forja_say 'Molding JavaScript interactions...'
  copy_template_directory('javascript', 'app/javascript')

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 4. RSpec + FactoryBot + Shoulda Matchers
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Sharpening test tools (RSpec, FactoryBot, Shoulda Matchers)...'

  generate 'rspec:install'

  # Remove default test directory (we use spec/ now)
  remove_dir 'test'

  # Use RSpec as the default test framework for generators
  application do
    <<~RUBY
      config.generators do |g|
          g.test_framework :rspec,
            fixtures:         false,
            view_specs:       false,
            helper_specs:     false,
            routing_specs:    false,
            request_specs:    true,
            controller_specs: false
        end
    RUBY
  end

  # FactoryBot configuration
  create_file 'spec/support/factory_bot.rb', <<~RUBY
    RSpec.configure do |config|
      config.include FactoryBot::Syntax::Methods
    end
  RUBY

  # Shoulda Matchers configuration
  create_file 'spec/support/shoulda_matchers.rb', <<~RUBY
    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end
  RUBY

  # Require support files in rails_helper
  inject_into_file 'spec/rails_helper.rb',
                   after: /# Add additional requires below this line.*\n/ do
    "Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }\n"
  end

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 5. Devise — User authentication
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Hammering out authentication with Devise...'

  generate 'devise:install'

  # Default mailer URL
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
              env: 'development'

  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
              env: 'test'

  # Generate User model
  generate 'devise', 'User'

  # Update mailer sender
  gsub_file 'config/initializers/devise.rb',
            "config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'",
            "config.mailer_sender = 'noreply@example.com'"

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 6. Copy Configuration Files (routes, etc.)
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Tempering configuration files...'
  copy_template_directory('config', 'config')

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 7. Devise Layout — Use dedicated auth layout
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Polishing custom Devise views with Oatmeal Olive theme...'

  inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
    <<-RUBY

  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  layout :layout_by_resource
    RUBY
  end

  # Create Devise layout
  create_file 'app/views/layouts/devise.html.erb',
              forja_read('layouts/devise.html.erb'), force: true

  # Copy custom Devise views
  %w[
    devise/sessions/new.html.erb
    devise/registrations/new.html.erb
    devise/registrations/edit.html.erb
    devise/passwords/new.html.erb
    devise/passwords/edit.html.erb
    devise/confirmations/new.html.erb
    devise/shared/_links.html.erb
    devise/shared/_error_messages.html.erb
  ].each do |view|
    create_file "app/views/#{view}", forja_read(view), force: true
  end

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 8. Database
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Casting the database mold...'

  rails_command 'db:create'
  rails_command 'db:migrate'

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 9. AI-Assisted Development Tools
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Setting up AI development agents with claude-on-rails...'

  generate 'claude_on_rails:swarm'

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 10. Git
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  forja_say 'Quenching the forge with an initial commit...'

  git add: '-A'
  git commit: '-m "Initial commit — forged with Forja 🔨"'

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # Done!
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say ''
  say '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━', :green
  say '  🔨 Forja — Your app has been forged!                             ', :green
  say '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━', :green
  say ''
  say "  ✅ Rails #{Rails::VERSION::STRING} + PostgreSQL"
  say '  ✅ Tailwind CSS (Oatmeal Olive + Instrument Serif)'
  say '  ✅ RSpec + FactoryBot + Shoulda Matchers'
  say '  ✅ Devise (User model created)'
  say '  ✅ Custom auth views (simple, no labels)'
  say '  ✅ claude-on-rails gem with swarm agents'
  say '  ✅ Component library & design system'
  say ''
  say '  Next steps:', :yellow
  say "    cd #{app_name}"
  say '    bin/dev                                  # Start the server'
  say ''
  say '  Visit http://localhost:3000 🚀'
  say ''
end
