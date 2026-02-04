# Forja

> *Spanish for "forge" — because every great app starts in the fire.*

Forja is an interactive CLI wizard to bootstrap new Rails applications with style. It generates a fully-configured Rails app with authentication, testing, and a beautiful UI theme out of the box.

## What You Get

Every app forged with Forja includes:

- **Rails 8+ with PostgreSQL** — Production-ready database setup
- **Tailwind CSS** — Custom "Oatmeal Olive" theme with Instrument Serif & Inter fonts
- **ViewComponent Library** — Pre-built UI components (buttons, forms, tables, modals, and more)
- **Design System** — Interactive component showcase in development mode
- **Devise Authentication** — User model with styled login/register views
- **RSpec Testing** — Pre-configured with FactoryBot and Shoulda Matchers
- **claude-on-rails** — AI-assisted development tools with swarm agents configured
- **Active Storage (Optional)** — File upload capabilities with local disk storage in development

## Prerequisites

Before using Forja, ensure you have:

- **Ruby 3.2+**
- **Rails 8.0+** (`gem install rails`)
- **PostgreSQL** installed and running
- **Node.js** (for Tailwind CSS)

Forja will check your Rails version before creating an app and provide clear instructions if an upgrade is needed.

## Installation

Install the gem:

```bash
gem install forja
```

Or add to your Gemfile:

```ruby
gem 'forja'
```

## Usage

### Quick Start

```bash
forja new my_app
```

This will:
1. Check that Rails 8.0+ is installed
2. Prompt for app name and location (if not provided)
3. Ask if you want to install Active Storage for file uploads
4. Run `rails new` with PostgreSQL and Tailwind
5. Copy component library and design system
6. Copy JavaScript interactions and controllers
7. Set up Devise authentication with custom views
8. Configure RSpec, FactoryBot, and Shoulda Matchers
9. Set up Active Storage (if selected) with local disk storage for development
10. Create and migrate the database
11. Set up claude-on-rails swarm agents for AI-assisted development
12. Make an initial git commit

### Command Options

```bash
# Interactive mode - prompts for everything
forja new

# Specify app name
forja new my_app

# Specify app name and path
forja new my_app --path ~/projects

# Show full Rails output
forja new my_app --verbose

# Disable colors
forja new my_app --no-color
```

### Options Reference

| Option | Description |
|--------|-------------|
| `--path PATH` | Directory to create the app in (default: current directory) |
| `--verbose` | Show full Rails generation output |
| `--no-color` | Disable colored output |

### Environment Variables

| Variable | Description |
|----------|-------------|
| `NO_COLOR` | When set, disables colored output |

## Example Session

```
$ forja new my_app --path /tmp

                              ⚒
                           ╔═════╗
                          ║ ⚒═══⚒ ║
                         ║  FORJA  ║
                          ║ ═════ ║
                           ╚═════╝
                         ≋≋≋≋≋≋≋≋≋≋≋
                        ≋  🔥🔥🔥  ≋
                       ≋≋≋≋≋≋≋≋≋≋≋≋≋
                      ║███████████████║
                      ║███████████████║
                      ╚═══════════════╝

Forja
Forge Rails apps, fast.

What is your app name? my_app
Do you want to install Active Storage for file uploads? (Y/n) y

[⠋] 🔨 Forging your Rails application…

🔨 Forging component library from the Forja template...
🔨 Molding JavaScript interactions...
🔨 Sharpening test tools (RSpec, FactoryBot, Shoulda Matchers)...
🔨 Hammering out authentication with Devise...
🔨 Forging Active Storage for file uploads...
🔨 Tempering configuration files...
🔨 Polishing custom Devise views with Oatmeal Olive theme...
🔨 Casting the database mold...
🔨 Setting up AI development agents with claude-on-rails...
🔨 Quenching the forge with an initial commit...

✓ App forged successfully!

🔨 App forged successfully!

  App name:  my_app
  Location:  /tmp/my_app

  Included:
    ✓ Rails + PostgreSQL
    ✓ Tailwind CSS (Oatmeal Olive theme)
    ✓ RSpec + FactoryBot + Shoulda Matchers
    ✓ Devise authentication (User model)
    ✓ Custom auth views
    ✓ claude-on-rails gem with swarm agents
    ✓ Component library & design system
    ✓ Active Storage (file uploads)

  Next steps:
    cd /tmp/my_app
    bin/dev

  Visit http://localhost:3000/design_system in development to explore components!

  Tip: Use --verbose for detailed output.
```

## Development

### Setup

Clone the repository and install dependencies:

```bash
git clone https://github.com/your-org/forja.git
cd forja
bundle install
```

### Running Forja Locally

During development, use `bundle exec` to run the local version:

```bash
# Show help
bundle exec exe/forja

# Create a new app (interactive)
bundle exec exe/forja new

# Create a new app with name
bundle exec exe/forja new test_app

# Create in a specific directory
bundle exec exe/forja new test_app --path /tmp

# See full Rails output (useful for debugging)
bundle exec exe/forja new test_app --path /tmp --verbose
```

### Running Tests

```bash
bundle exec rake spec
```

### Interactive Console

Load Forja in an IRB session:

```bash
bin/console
```

Example:

```ruby
# Test validation
Forja::Validation.valid_app_name?("my_app")  # => true
Forja::Validation.valid_app_name?("123bad")  # => false

# Create a spec manually
spec = Forja::Spec.new(name: "test", path: "/tmp")
spec.full_path  # => "/tmp/test"
```

### Project Structure

```
forja/
├── exe/
│   └── forja              # CLI entry point
├── lib/
│   ├── forja.rb           # Main module
│   └── forja/
│       ├── cli.rb         # Thor commands
│       ├── wizard.rb      # Interactive prompts
│       ├── runner.rb      # Rails generation
│       ├── ui.rb          # Output formatting
│       ├── spec.rb        # App configuration
│       ├── validation.rb  # Input validation
│       ├── errors.rb      # Custom errors
│       └── version.rb     # Version constant
├── templates/             # Files copied to generated apps
│   ├── app/
│   ├── devise/            # Custom auth views
│   ├── layouts/
│   └── tailwind.css       # Custom theme
├── template.rb            # Rails application template
└── spec/                  # RSpec tests
```

### How It Works

1. **CLI** (`cli.rb`) parses arguments using Thor
2. **Wizard** (`wizard.rb`) collects user input via TTY::Prompt
3. **Spec** (`spec.rb`) stores the configuration as an immutable object
4. **Runner** (`runner.rb`) executes `rails new` with the template
5. **Template** (`template.rb`) configures the generated app:
   - Adds gems (RSpec, Devise, etc.)
   - Runs generators after bundle
   - Copies custom views from `templates/`
   - Creates database and runs migrations
   - Makes initial git commit

### Modifying the Template

The main template logic is in `template.rb`. It uses Rails' template API:

```ruby
# Add gems
gem 'devise'
gem_group :test do
  gem 'rspec-rails'
end

# Run after bundle install
after_bundle do
  generate 'devise:install'
  generate 'devise', 'User'

  # Copy files from templates/ directory
  create_file 'app/views/...', forja_read('path/to/template')
end
```

The `forja_read` helper reads files from the `templates/` directory.

### Building and Installing Locally

```bash
# Build the gem
gem build forja.gemspec

# Install locally
gem install ./forja-0.1.0.gem

# Now you can use it without bundle exec
forja new my_app
```

## Architecture

| Class | Responsibility |
|-------|----------------|
| `Forja::CLI` | Thor commands, option parsing |
| `Forja::Wizard` | Interactive prompts, user input |
| `Forja::Runner` | Executes `rails new` with template |
| `Forja::UI` | Banner, colors, formatted output |
| `Forja::Spec` | Immutable app configuration |
| `Forja::Validation` | App name and path validation |
| `Forja::Errors` | Custom exception classes |

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

MIT — forge freely.
