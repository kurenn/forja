# frozen_string_literal: true

module DesignSystem
  class ComponentsController < BaseController
    def index
      @components = COMPONENT_REGISTRY
    end

    def show
      @component = COMPONENT_REGISTRY[params[:name].to_sym]

      raise ActionController::RoutingError, "Component Not Found" unless @component
    end

    COMPONENT_REGISTRY = {
      button: {
        name: "Button",
        category: "UI",
        description: "A flexible button component with multiple variants and colors.",
        class_name: "ButtonComponent",
        parameters: [
          { name: "variant", type: "Symbol", default: ":solid", options: ":solid, :outline, :plain", description: "Visual style of the button" },
          { name: "color", type: "Symbol", default: ":olive", options: ":olive, :red, :green, :blue, etc.", description: "Button color" },
          { name: "href", type: "String", default: "nil", description: "If provided, renders as a link" },
          { name: "type", type: "String", default: '"button"', description: "Button type (button, submit, reset)" },
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the button" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes passed to button element" }
        ],
        examples: [
          {
            title: "Primary Button",
            description: "Default button style for primary actions.",
            code: '<%= render ButtonComponent.new do %>Save Changes<% end %>'
          },
          {
            title: "Outline Button",
            description: "Outline button for secondary actions.",
            code: '<%= render ButtonComponent.new(variant: :outline) do %>Cancel<% end %>'
          },
          {
            title: "Plain Button",
            description: "Plain button without background.",
            code: '<%= render ButtonComponent.new(variant: :plain) do %>Learn more<% end %>'
          },
          {
            title: "Colored Buttons",
            description: "Buttons available in multiple colors.",
            code: '<%= render ButtonComponent.new(color: :red) do %>Delete<% end %>
<%= render ButtonComponent.new(color: :green) do %>Approve<% end %>
<%= render ButtonComponent.new(color: :blue) do %>Info<% end %>'
          },
          {
            title: "Disabled State",
            description: "Disabled buttons cannot be clicked.",
            code: '<%= render ButtonComponent.new(disabled: true) do %>Disabled<% end %>'
          }
        ]
      },
      badge: {
        name: "Badge",
        category: "UI",
        description: "Small status indicators and labels.",
        class_name: "BadgeComponent",
        parameters: [
          { name: "color", type: "Symbol", default: ":olive", options: ":olive, :red, :green, :blue, :amber, etc.", description: "Badge color" },
          { name: "href", type: "String", default: "nil", description: "Optional link URL (makes badge interactive)" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Status Badges",
            description: "Use badges to indicate status.",
            code: '<%= render BadgeComponent.new(color: :green) do %>Active<% end %>
<%= render BadgeComponent.new(color: :amber) do %>Pending<% end %>
<%= render BadgeComponent.new(color: :red) do %>Revoked<% end %>'
          },
          {
            title: "Default Badge",
            description: "Default olive colored badge.",
            code: '<%= render BadgeComponent.new do %>Default<% end %>'
          }
        ]
      },
      modal: {
        name: "Modal",
        category: "UI",
        description: "Modal dialogs for focused user interactions.",
        class_name: "ModalComponent",
        parameters: [
          { name: "id", type: "String", default: "required", description: "Unique identifier for the modal" },
          { name: "title", type: "String", default: "nil", description: "Optional modal title" },
          { name: "size", type: "Symbol", default: ":lg", options: ":sm, :md, :lg, :xl, :full", description: "Modal size" },
          { name: "icon", type: "String", default: "nil", options: '"check", "x", "exclamation", "info"', description: "Optional icon for header" },
          { name: "icon_variant", type: "Symbol", default: ":success", options: ":success, :danger, :warning, :info", description: "Icon color variant" }
        ],
        examples: [
          {
            title: "Basic Modal",
            description: "A simple modal with title and content.",
            code: '<%= render ModalComponent.new(id: "confirm-dialog", title: "Confirm Action") do %>
  <p class="text-olive-700 dark:text-olive-300">Are you sure you want to proceed?</p>
<% end %>'
          },
          {
            title: "Modal with Icon",
            description: "Modal with a status icon.",
            code: '<%= render ModalComponent.new(id: "success-modal", title: "Success", icon: "check", icon_variant: :success) do %>
  <p class="text-olive-700 dark:text-olive-300">Your changes have been saved.</p>
<% end %>'
          }
        ]
      },
      avatar: {
        name: "Avatar",
        category: "UI",
        description: "User avatar display with initials fallback.",
        class_name: "AvatarComponent",
        parameters: [
          { name: "src", type: "String", default: "nil", description: "Image URL for avatar" },
          { name: "alt", type: "String", default: '""', description: "Alt text for image" },
          { name: "initials", type: "String", default: "nil", description: "Initials to display when no image" },
          { name: "square", type: "Boolean", default: "false", description: "Use square shape instead of circle" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Avatar with Initials",
            description: "Display initials when no image is available.",
            code: '<%= render AvatarComponent.new(initials: "JD", alt: "John Doe") %>'
          },
          {
            title: "Square Avatar",
            description: "Avatar with square shape.",
            code: '<%= render AvatarComponent.new(initials: "AB", square: true) %>'
          }
        ]
      },
      heading: {
        name: "Heading",
        category: "UI",
        description: "Semantic heading component with consistent styling.",
        class_name: "HeadingComponent",
        parameters: [
          { name: "level", type: "Integer", default: "1", options: "1, 2, 3, 4, 5, 6", description: "Heading level (h1-h6)" },
          { name: "subheading", type: "Boolean", default: "false", description: "Use smaller subheading style" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Heading Levels",
            description: "Different heading levels.",
            code: '<%= render HeadingComponent.new(level: 1) do %>Heading 1<% end %>
<%= render HeadingComponent.new(level: 2) do %>Heading 2<% end %>
<%= render HeadingComponent.new(level: 3) do %>Heading 3<% end %>'
          },
          {
            title: "Subheading",
            description: "Smaller subheading style.",
            code: '<%= render HeadingComponent.new(level: 2, subheading: true) do %>Subheading<% end %>'
          }
        ]
      },
      text: {
        name: "Text",
        category: "UI",
        description: "Body text component with consistent styling.",
        class_name: "TextComponent",
        parameters: [
          { name: "as", type: "Symbol", default: ":p", options: ":p, :span, :div", description: "HTML tag to use" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Text",
            description: "Paragraph text with consistent styling.",
            code: '<%= render TextComponent.new do %>This is body text with consistent styling.<% end %>'
          },
          {
            title: "Inline Text",
            description: "Text as inline span.",
            code: '<%= render TextComponent.new(as: :span) do %>Inline text<% end %>'
          }
        ]
      },
      link: {
        name: "Link",
        category: "UI",
        description: "Styled link component.",
        class_name: "LinkComponent",
        parameters: [
          { name: "href", type: "String", default: "required", description: "Link URL" },
          { name: "variant", type: "Symbol", default: ":default", options: ":default, :text", description: "Link style" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Link",
            description: "A styled link.",
            code: '<%= render LinkComponent.new(href: "#") do %>Go to Dashboard<% end %>'
          },
          {
            title: "Text Link",
            description: "Underlined text link.",
            code: '<%= render LinkComponent.new(href: "#", variant: :text) do %>Documentation<% end %>'
          }
        ]
      },
      divider: {
        name: "Divider",
        category: "UI",
        description: "Horizontal divider for separating content.",
        class_name: "DividerComponent",
        parameters: [
          { name: "soft", type: "Boolean", default: "false", description: "Use softer color" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Divider",
            description: "A horizontal divider.",
            code: '<%= render DividerComponent.new %>'
          },
          {
            title: "Soft Divider",
            description: "A softer colored divider.",
            code: '<%= render DividerComponent.new(soft: true) %>'
          }
        ]
      },
      code: {
        name: "Code",
        category: "UI",
        description: "Inline code styling component.",
        class_name: "CodeComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Inline Code",
            description: "Display inline code.",
            code: '<%= render CodeComponent.new do %>const x = 1<% end %>'
          }
        ]
      },
      strong: {
        name: "Strong",
        category: "UI",
        description: "Bold/strong text component.",
        class_name: "StrongComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Strong Text",
            description: "Bold text styling.",
            code: '<%= render StrongComponent.new do %>Important text<% end %>'
          }
        ]
      },
      dropdown: {
        name: "Dropdown",
        category: "UI",
        description: "Dropdown menu with configurable items.",
        class_name: "DropdownComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Dropdown",
            description: "A dropdown menu with items.",
            code: '<%= render DropdownComponent.new do |dropdown| %>
  <% dropdown.with_button do %>Options<% end %>
  <% dropdown.with_menu do %>
    <%= render DropdownItemComponent.new(href: "#") do %>Edit<% end %>
    <%= render DropdownItemComponent.new(href: "#") do %>Delete<% end %>
  <% end %>
<% end %>'
          }
        ]
      },
      dialog: {
        name: "Dialog",
        category: "UI",
        description: "Modal dialog component with backdrop.",
        class_name: "DialogComponent",
        parameters: [
          { name: "id", type: "String", default: "required", description: "Unique identifier" },
          { name: "open", type: "Boolean", default: "false", description: "Initial open state" },
          { name: "size", type: "Symbol", default: ":lg", options: ":xs, :sm, :md, :lg, :xl, :2xl, etc.", description: "Dialog size" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Dialog",
            description: "A dialog with title and description.",
            code: '<%= render DialogComponent.new(id: "confirm", open: false) do |dialog| %>
  <% dialog.with_title { "Confirm action" } %>
  <% dialog.with_description { "Are you sure you want to proceed?" } %>
  <% dialog.with_actions do %>
    <%= render ButtonComponent.new(variant: :outline) do %>Cancel<% end %>
    <%= render ButtonComponent.new do %>Confirm<% end %>
  <% end %>
<% end %>'
          }
        ]
      },
      table: {
        name: "Table",
        category: "UI",
        description: "Data table component with header, body, and rows.",
        class_name: "TableComponent",
        parameters: [
          { name: "bleed", type: "Boolean", default: "false", description: "Allow table to bleed to edges" },
          { name: "dense", type: "Boolean", default: "false", description: "Use compact row padding" },
          { name: "grid", type: "Boolean", default: "false", description: "Show vertical grid lines" },
          { name: "striped", type: "Boolean", default: "false", description: "Alternate row backgrounds" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Table",
            description: "A data table with headers and rows.",
            code: '<%= render TableComponent.new do %>
  <%= render TableHeadComponent.new do %>
    <%= render TableRowComponent.new do %>
      <%= render TableHeaderComponent.new do %>Name<% end %>
      <%= render TableHeaderComponent.new do %>Email<% end %>
    <% end %>
  <% end %>
  <%= render TableBodyComponent.new do %>
    <%= render TableRowComponent.new do %>
      <%= render TableCellComponent.new do %>John Doe<% end %>
      <%= render TableCellComponent.new do %>john@example.com<% end %>
    <% end %>
  <% end %>
<% end %>'
          }
        ]
      },
      pagination: {
        name: "Pagination",
        category: "UI",
        description: "Pagination component for navigating through pages.",
        class_name: "PaginationComponent",
        parameters: [
          { name: "aria_label", type: "String", default: '"Page navigation"', description: "Accessible label" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Pagination",
            description: "Pagination with previous, next, and page numbers.",
            code: '<%= render PaginationComponent.new do %>
  <%= render PaginationPreviousComponent.new(href: "#") %>
  <%= render PaginationListComponent.new do %>
    <%= render PaginationPageComponent.new(href: "#", current: true) do %>1<% end %>
    <%= render PaginationPageComponent.new(href: "#") do %>2<% end %>
    <%= render PaginationPageComponent.new(href: "#") do %>3<% end %>
  <% end %>
  <%= render PaginationNextComponent.new(href: "#") %>
<% end %>'
          }
        ]
      },
      flash: {
        name: "Flash",
        category: "UI",
        description: "Flash message notification component.",
        class_name: "FlashComponent",
        parameters: [
          { name: "type", type: "Symbol", default: "required", options: ":notice, :alert, :warning, :info", description: "Flash type" },
          { name: "message", type: "String", default: "required", description: "Message to display" },
          { name: "description", type: "String", default: "nil", description: "Optional detailed description" }
        ],
        examples: [
          {
            title: "Flash Messages",
            description: "Different types of flash messages.",
            code: '<%= render FlashComponent.new(type: :notice, message: "Successfully saved!") %>
<%= render FlashComponent.new(type: :alert, message: "Something went wrong") %>
<%= render FlashComponent.new(type: :warning, message: "Please check your input") %>
<%= render FlashComponent.new(type: :info, message: "New features available") %>'
          }
        ]
      },
      description_list: {
        name: "Description List",
        category: "UI",
        description: "Definition list for key-value pairs.",
        class_name: "DescriptionListComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Description List",
            description: "A list of term-details pairs.",
            code: '<%= render DescriptionListComponent.new do %>
  <%= render DescriptionTermComponent.new do %>Name<% end %>
  <%= render DescriptionDetailsComponent.new do %>John Doe<% end %>
  <%= render DescriptionTermComponent.new do %>Email<% end %>
  <%= render DescriptionDetailsComponent.new do %>john@example.com<% end %>
<% end %>'
          }
        ]
      },
      input: {
        name: "Input",
        category: "Form",
        description: "Form input field component.",
        class_name: "Form::InputComponent",
        parameters: [
          { name: "type", type: "String", default: '"text"', description: "Input type" },
          { name: "name", type: "String", default: "nil", description: "Input name attribute" },
          { name: "value", type: "String", default: "nil", description: "Input value" },
          { name: "placeholder", type: "String", default: "nil", description: "Placeholder text" },
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the input" },
          { name: "invalid", type: "Boolean", default: "false", description: "Show error state" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Input",
            description: "A text input field.",
            code: '<%= render Form::InputComponent.new(name: "email", type: "email", placeholder: "Enter your email") %>'
          },
          {
            title: "Invalid Input",
            description: "Input with error state.",
            code: '<%= render Form::InputComponent.new(name: "email", invalid: true, placeholder: "Invalid email") %>'
          },
          {
            title: "Disabled Input",
            description: "Disabled input field.",
            code: '<%= render Form::InputComponent.new(name: "readonly", disabled: true, value: "Cannot edit") %>'
          }
        ]
      },
      select: {
        name: "Select",
        category: "Form",
        description: "Form select dropdown component.",
        class_name: "Form::SelectComponent",
        parameters: [
          { name: "name", type: "String", default: "nil", description: "Select name attribute" },
          { name: "multiple", type: "Boolean", default: "false", description: "Allow multiple selections" },
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the select" },
          { name: "invalid", type: "Boolean", default: "false", description: "Show error state" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Select",
            description: "A select dropdown.",
            code: '<%= render Form::SelectComponent.new(name: "country") do %>
  <option value="">Select a country</option>
  <option value="us">United States</option>
  <option value="uk">United Kingdom</option>
<% end %>'
          }
        ]
      },
      textarea: {
        name: "Textarea",
        category: "Form",
        description: "Multi-line text input component.",
        class_name: "Form::TextareaComponent",
        parameters: [
          { name: "name", type: "String", default: "nil", description: "Textarea name attribute" },
          { name: "rows", type: "Integer", default: "3", description: "Number of visible rows" },
          { name: "resizable", type: "Boolean", default: "true", description: "Allow resizing" },
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the textarea" },
          { name: "invalid", type: "Boolean", default: "false", description: "Show error state" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Textarea",
            description: "A multi-line text input.",
            code: '<%= render Form::TextareaComponent.new(name: "description", rows: 4, placeholder: "Enter description...") %>'
          }
        ]
      },
      checkbox: {
        name: "Checkbox",
        category: "Form",
        description: "Checkbox input component.",
        class_name: "Form::CheckboxComponent",
        parameters: [
          { name: "name", type: "String", default: "nil", description: "Checkbox name attribute" },
          { name: "value", type: "String", default: '"1"', description: "Checkbox value" },
          { name: "checked", type: "Boolean", default: "false", description: "Checked state" },
          { name: "color", type: "Symbol", default: ":olive", description: "Checkbox color when checked" },
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the checkbox" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Checkbox",
            description: "A checkbox input.",
            code: '<%= render Form::CheckboxComponent.new(name: "terms") %>'
          },
          {
            title: "Checked Checkbox",
            description: "A pre-checked checkbox.",
            code: '<%= render Form::CheckboxComponent.new(name: "subscribe", checked: true) %>'
          },
          {
            title: "Colored Checkbox",
            description: "Checkbox with custom color.",
            code: '<%= render Form::CheckboxComponent.new(name: "feature", color: :green, checked: true) %>'
          }
        ]
      },
      radio: {
        name: "Radio",
        category: "Form",
        description: "Radio button input component.",
        class_name: "Form::RadioComponent",
        parameters: [
          { name: "name", type: "String", default: "nil", description: "Radio name attribute" },
          { name: "value", type: "String", default: "nil", description: "Radio value" },
          { name: "checked", type: "Boolean", default: "false", description: "Checked state" },
          { name: "color", type: "Symbol", default: ":olive", description: "Radio color when checked" },
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the radio" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Radio Group",
            description: "A group of radio buttons.",
            code: '<%= render Form::RadioComponent.new(name: "plan", value: "free", checked: true) %>
<%= render Form::RadioComponent.new(name: "plan", value: "pro") %>
<%= render Form::RadioComponent.new(name: "plan", value: "enterprise") %>'
          }
        ]
      },
      switch: {
        name: "Switch",
        category: "Form",
        description: "Toggle switch component.",
        class_name: "Form::SwitchComponent",
        parameters: [
          { name: "name", type: "String", default: "nil", description: "Switch name attribute" },
          { name: "value", type: "String", default: '"1"', description: "Switch value when on" },
          { name: "checked", type: "Boolean", default: "false", description: "On state" },
          { name: "color", type: "Symbol", default: ":olive", description: "Switch color when on" },
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the switch" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Switch",
            description: "A toggle switch.",
            code: '<%= render Form::SwitchComponent.new(name: "notifications") %>'
          },
          {
            title: "Enabled Switch",
            description: "A switch that is on.",
            code: '<%= render Form::SwitchComponent.new(name: "enabled", checked: true) %>'
          },
          {
            title: "Colored Switch",
            description: "Switch with custom color.",
            code: '<%= render Form::SwitchComponent.new(name: "feature", color: :green, checked: true) %>'
          }
        ]
      },
      field: {
        name: "Field",
        category: "Form",
        description: "Form field wrapper with proper spacing for labels and controls.",
        class_name: "Form::FieldComponent",
        parameters: [
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the field" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Complete Field",
            description: "A field with label and input.",
            code: '<%= render Form::FieldComponent.new do %>
  <%= render Form::LabelComponent.new(for: "email") do %>Email<% end %>
  <%= render Form::InputComponent.new(id: "email", name: "email", type: "email") %>
<% end %>'
          }
        ]
      },
      fieldset: {
        name: "Fieldset",
        category: "Form",
        description: "Fieldset for grouping related form fields.",
        class_name: "Form::FieldsetComponent",
        parameters: [
          { name: "disabled", type: "Boolean", default: "false", description: "Disable the fieldset" },
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Fieldset",
            description: "A fieldset with legend.",
            code: '<%= render Form::FieldsetComponent.new do %>
  <%= render Form::LegendComponent.new do %>Personal Information<% end %>
  <%= render Form::FieldGroupComponent.new do %>
    <%= render Form::FieldComponent.new do %>
      <%= render Form::LabelComponent.new do %>Name<% end %>
      <%= render Form::InputComponent.new(name: "name") %>
    <% end %>
  <% end %>
<% end %>'
          }
        ]
      },
      dashboard_layout: {
        name: "Dashboard Layout",
        category: "Layout",
        description: "Main layout with sidebar navigation.",
        class_name: "Layout::DashboardLayoutComponent",
        parameters: [
          { name: "controller", type: "String", default: "nil", description: "Current controller name" }
        ],
        examples: [
          {
            title: "Basic Usage",
            description: "Wrap your page content with the dashboard layout. Note: This component requires authentication context.",
            code: '<%# In your view: %>
<%# <%= render Layout::DashboardLayoutComponent.new do %> %>
<%#   <h1>Page Content</h1> %>
<%# <% end %> %>'
          }
        ]
      },
      sidebar: {
        name: "Sidebar",
        category: "Layout",
        description: "Sidebar navigation component.",
        class_name: "Layout::SidebarComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Sidebar",
            description: "A sidebar with navigation structure.",
            code: '<%= render Layout::SidebarComponent.new do %>
  <%= render Layout::SidebarHeaderComponent.new do %>
    <span class="text-lg font-semibold">App Name</span>
  <% end %>
  <%= render Layout::SidebarBodyComponent.new do %>
    <%= render Layout::SidebarSectionComponent.new do %>
      <%= render Layout::SidebarItemComponent.new(href: "#") do %>Home<% end %>
      <%= render Layout::SidebarItemComponent.new(href: "#") do %>Settings<% end %>
    <% end %>
  <% end %>
<% end %>'
          }
        ]
      },
      navbar: {
        name: "Navbar",
        category: "Layout",
        description: "Top navigation bar component.",
        class_name: "Layout::NavbarComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Navbar",
            description: "A navigation bar with sections.",
            code: '<%= render Layout::NavbarComponent.new do %>
  <%= render Layout::NavbarSectionComponent.new do %>
    <%= render Layout::NavbarItemComponent.new(href: "#") do %>Home<% end %>
    <%= render Layout::NavbarItemComponent.new(href: "#") do %>About<% end %>
  <% end %>
  <%= render Layout::NavbarSpacerComponent.new %>
  <%= render Layout::NavbarSectionComponent.new do %>
    <%= render Layout::NavbarItemComponent.new(href: "#") do %>Profile<% end %>
  <% end %>
<% end %>'
          }
        ]
      },
      stacked_layout: {
        name: "Stacked Layout",
        category: "Layout",
        description: "Layout with navbar at top and collapsible sidebar on mobile.",
        class_name: "Layout::StackedLayoutComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Stacked Layout",
            description: "A stacked layout with sidebar and navbar slots.",
            code: '<%= render Layout::StackedLayoutComponent.new do |layout| %>
  <% layout.with_sidebar do %>
    <%= render Layout::SidebarComponent.new do %>
      <!-- Mobile sidebar content -->
    <% end %>
  <% end %>
  <% layout.with_navbar do %>
    <%= render Layout::NavbarComponent.new do %>
      <!-- Navbar content -->
    <% end %>
  <% end %>
  <!-- Main content here -->
<% end %>'
          }
        ]
      },
      auth_layout: {
        name: "Auth Layout",
        category: "Layout",
        description: "Centered layout for authentication pages.",
        class_name: "Layout::AuthLayoutComponent",
        parameters: [
          { name: "**options", type: "Hash", default: "{}", description: "HTML attributes" }
        ],
        examples: [
          {
            title: "Basic Auth Layout",
            description: "A centered layout for login/signup forms.",
            code: '<%= render Layout::AuthLayoutComponent.new do %>
  <div class="w-full max-w-sm">
    <h1 class="text-2xl font-bold text-olive-900 dark:text-olive-100">Sign in</h1>
    <p class="mt-2 text-olive-600 dark:text-olive-400">Enter your credentials below.</p>
  </div>
<% end %>'
          }
        ]
      }
    }.freeze
  end
end
