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

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 1. Gems
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Testing
gem_group :development, :test do
  gem 'rspec-rails', '~> 7.0'
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

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 2. Bundle
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

after_bundle do

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 3. Tailwind CSS — Oatmeal Olive theme with Instrument Serif
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say "🎨 Installing custom Oatmeal Olive Tailwind theme..."

  # Overwrite the default tailwind CSS with custom olive theme
  tailwind_path = 'app/assets/stylesheets/application.tailwind.css'
  create_file tailwind_path, forja_read('tailwind.css'), force: true

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 4. RSpec + FactoryBot + Shoulda Matchers
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say "🧪 Setting up RSpec, FactoryBot, and Shoulda Matchers..."

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

  say "🔐 Setting up Devise with User model..."

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
  # 6. Devise Layout — Use dedicated auth layout
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say "🖼️  Installing custom Devise views with Oatmeal Olive theme..."

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
  # 7. Application Layout — Add Google Fonts
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say "🔤 Adding Instrument Serif & Inter fonts..."

  inject_into_file 'app/views/layouts/application.html.erb',
    before: '    <%= csrf_meta_tags %>' do
    <<-HTML
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Inter:opsz,wght@14..32,100..900&display=swap" rel="stylesheet">

    HTML
  end

  # Add body classes to application layout
  gsub_file 'app/views/layouts/application.html.erb',
    '<body>',
    '<body class="min-h-screen bg-olive-100 font-sans antialiased dark:bg-olive-950">'

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 8. Home Page + Root Route
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say "🏠 Creating home page..."

  generate 'controller', 'Home', 'index', '--skip-routes', '--no-helper', '--no-test-framework'

  create_file 'app/views/home/index.html.erb',
    forja_read('home/index.html.erb'), force: true

  route "root 'home#index'"

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 9. Database
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say "🗄️  Creating and migrating database..."

  rails_command 'db:create'
  rails_command 'db:migrate'

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # 10. Git
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  git add: '-A'
  git commit: '-m "Initial commit — forged with Forja 🔨"'

  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  # Done!
  # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  say ""
  say "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━", :green
  say "  🔨 Forja — Your app has been forged!                             ", :green
  say "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━", :green
  say ""
  say "  ✅ Rails #{Rails::VERSION::STRING} + PostgreSQL"
  say "  ✅ Tailwind CSS (Oatmeal Olive + Instrument Serif)"
  say "  ✅ RSpec + FactoryBot + Shoulda Matchers"
  say "  ✅ Devise (User model created)"
  say "  ✅ Custom auth views (simple, no labels)"
  say "  ✅ claude-on-rails gem installed"
  say ""
  say "  Next steps:", :yellow
  say "    cd #{app_name}"
  say "    rails generate claude_on_rails:swarm    # Set up AI dev agents"
  say "    bin/dev                                  # Start the server"
  say ""
  say "  Visit http://localhost:3000 🚀"
  say ""
end
