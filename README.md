# 🔨 Forja

> *Spanish for "forge" — because every great app starts in the fire.*

A Rails application template that gives you a production-ready foundation with a beautiful UI out of the box.

## What You Get

| Feature | Details |
|---------|---------|
| **Framework** | Rails 8.1+ with PostgreSQL |
| **CSS** | Tailwind CSS v4 with the Oatmeal Olive theme (Instrument Serif + Inter) |
| **Auth** | Devise with fully styled views — clean, no-label forms |
| **Testing** | RSpec, FactoryBot, Shoulda Matchers (configured & ready) |
| **AI Dev** | claude-on-rails for AI-assisted development with Claude Code |

## Quick Start

```bash
rails new myapp -d postgresql --css=tailwind -m ~/workspace/workspace/forja/template.rb
```

That's it. One command. The template handles everything:

1. Installs and configures all gems
2. Sets up RSpec with FactoryBot & Shoulda Matchers
3. Installs Devise with a `User` model
4. Deploys custom auth views with the Oatmeal Olive design
5. Applies the Tailwind theme (olive colors, Instrument Serif display font, Inter body font)
6. Creates a home page with sign-in/sign-up links
7. Creates and migrates the database
8. Makes an initial git commit

## After Creation

```bash
cd myapp

# Set up claude-on-rails AI development agents (optional but recommended)
rails generate claude_on_rails:swarm

# Start the dev server
bin/dev
```

Visit [http://localhost:3000](http://localhost:3000) and you'll see your app running with the Oatmeal Olive theme.

## Design System

The template uses the **Oatmeal Olive** theme from [Tailwind Plus](https://tailwindcss.com/plus) with the **Instrument** font variant:

- **Display font:** Instrument Serif (headings, hero text)
- **Body font:** Inter (everything else)
- **Color palette:** Olive — warm, earthy tones based on oklch
- **Dark mode:** Fully supported via Tailwind's `dark:` variant
- **Auth forms:** "Simple, no labels" pattern from Tailwind UI — clean inputs with sr-only labels for accessibility

### Color Palette

| Token | Light | Dark |
|-------|-------|------|
| `olive-50` | Nearly white | — |
| `olive-100` | Page background | — |
| `olive-300` | Borders, dividers | — |
| `olive-400` | Placeholder text | — |
| `olive-500` | Muted text | — |
| `olive-600` | Primary buttons, links | Accent |
| `olive-700` | Body text | — |
| `olive-900` | Heading text | — |
| `olive-950` | Darkest | Page bg (dark mode) |

### Usage in Views

```erb
<%# Display font (Instrument Serif) %>
<h1 class="font-display text-4xl text-olive-950 dark:text-olive-50">
  Welcome
</h1>

<%# Body text (Inter) %>
<p class="font-sans text-olive-700 dark:text-olive-300">
  Regular content uses Inter automatically.
</p>

<%# Primary button %>
<button class="rounded-lg bg-olive-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-olive-500">
  Get Started
</button>

<%# Input (no-label style) %>
<input type="email" placeholder="Email address"
  class="block w-full rounded-lg border-0 bg-white px-3.5 py-2.5 text-olive-950 shadow-sm ring-1 ring-inset ring-olive-300 placeholder:text-olive-400 focus:ring-2 focus:ring-inset focus:ring-olive-600 sm:text-sm/6">
```

## Customizing Devise Views

All Devise views live in `app/views/devise/` and use the Oatmeal Olive design:

```
app/views/devise/
├── sessions/
│   └── new.html.erb              # Sign in
├── registrations/
│   ├── new.html.erb              # Sign up
│   └── edit.html.erb             # Edit profile
├── passwords/
│   ├── new.html.erb              # Forgot password
│   └── edit.html.erb             # Reset password
├── confirmations/
│   └── new.html.erb              # Resend confirmation
└── shared/
    ├── _error_messages.html.erb  # Validation errors
    └── _links.html.erb           # Navigation links
```

Auth pages use a dedicated layout at `app/views/layouts/devise.html.erb` — minimal, centered, with just the olive background and Google Fonts.

## Testing

The test stack is configured and ready:

```bash
# Run all specs
bundle exec rspec

# Run a specific spec
bundle exec rspec spec/models/user_spec.rb
```

FactoryBot syntax methods (`create`, `build`, etc.) are included globally. Shoulda Matchers are configured for Rails + RSpec.

## AI Development with Claude

After running `rails generate claude_on_rails:swarm`, you can use Claude Code with specialized AI agents:

```bash
# Start the AI development swarm
claude-swarm
```

Then describe what you want to build in natural language and the agent swarm handles the rest.

## Prerequisites

- Ruby 3.2+
- Rails 8.1+
- PostgreSQL
- Node.js (for Tailwind CSS build)

## License

MIT — forge freely.
