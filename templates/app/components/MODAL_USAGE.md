# ModalComponent Usage Examples

## Basic Usage

### Simple Modal
```erb
<!-- In your view -->
<button type="button"
        onclick="document.dispatchEvent(new CustomEvent('modal:open:confirm-action'))">
  Open Modal
</button>

<%= render ModalComponent.new(id: 'confirm-action', title: 'Confirm Action') do %>
  Are you sure you want to proceed with this action?
<% end %>
```

### Modal with Icon
```erb
<%= render ModalComponent.new(
  id: 'success-modal',
  title: 'Payment Successful',
  icon: 'check',
  icon_variant: :success
) do %>
  Your payment has been processed successfully!
<% end %>
```

### Modal with Slots (Recommended for Complex Content)
```erb
<%= render ModalComponent.new(id: 'user-modal', size: :lg) do |modal| %>
  <% modal.with_title { 'Edit User' } %>
  
  <% modal.with_body do %>
    <%= form_with model: @user do |f| %>
      <div class="space-y-4">
        <%= f.text_field :name, class: 'w-full' %>
        <%= f.email_field :email, class: 'w-full' %>
      </div>
    <% end %>
  <% end %>
  
  <% modal.with_actions do %>
    <div class="flex justify-end gap-3">
      <button type="button"
              onclick="document.dispatchEvent(new CustomEvent('modal:close:user-modal'))"
              class="btn btn-secondary">
        Cancel
      </button>
      <button type="submit" class="btn btn-primary">
        Save Changes
      </button>
    </div>
  <% end %>
<% end %>
```

## Opening and Closing Modals

### From JavaScript
```javascript
// Open modal
document.dispatchEvent(new CustomEvent('modal:open:modal-id'))

// Close modal
document.dispatchEvent(new CustomEvent('modal:close:modal-id'))
```

### From Stimulus Controller
```javascript
// app/javascript/controllers/my_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  openModal() {
    document.dispatchEvent(new CustomEvent('modal:open:confirm-delete'))
  }

  closeModal() {
    document.dispatchEvent(new CustomEvent('modal:close:confirm-delete'))
  }
}
```

### From Server-Side (Turbo Stream)
```ruby
# In your controller
def create
  @user = User.create(user_params)
  
  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.update('user-list', partial: 'users/list', locals: { users: User.all }),
        turbo_stream.append('body', '<script>document.dispatchEvent(new CustomEvent("modal:close:user-form"))</script>')
      ]
    end
  end
end
```

## Size Variants

```erb
<!-- Small modal -->
<%= render ModalComponent.new(id: 'small', size: :sm) do %>
  Small modal content
<% end %>

<!-- Medium modal -->
<%= render ModalComponent.new(id: 'medium', size: :md) do %>
  Medium modal content
<% end %>

<!-- Large modal (default) -->
<%= render ModalComponent.new(id: 'large', size: :lg) do %>
  Large modal content
<% end %>

<!-- Extra large modal -->
<%= render ModalComponent.new(id: 'xl', size: :xl) do %>
  Extra large modal content
<% end %>

<!-- Full width modal -->
<%= render ModalComponent.new(id: 'full', size: :full) do %>
  Full width modal content
<% end %>
```

## Icon Variants

```erb
<!-- Success -->
<%= render ModalComponent.new(id: 'success', icon: 'check', icon_variant: :success) do %>
  Operation completed successfully
<% end %>

<!-- Danger/Error -->
<%= render ModalComponent.new(id: 'error', icon: 'x', icon_variant: :danger) do %>
  An error occurred
<% end %>

<!-- Warning -->
<%= render ModalComponent.new(id: 'warning', icon: 'exclamation', icon_variant: :warning) do %>
  Please proceed with caution
<% end %>

<!-- Info -->
<%= render ModalComponent.new(id: 'info', icon: 'info', icon_variant: :info) do %>
  Here's some useful information
<% end %>
```

## Common Patterns

### Confirmation Dialog
```erb
<%= render ModalComponent.new(
  id: 'delete-confirm',
  title: 'Delete Item',
  icon: 'exclamation',
  icon_variant: :danger
) do |modal| %>
  <% modal.with_body do %>
    <p class="text-sm text-gray-500">
      Are you sure you want to delete this item? This action cannot be undone.
    </p>
  <% end %>
  
  <% modal.with_actions do %>
    <div class="sm:grid sm:grid-flow-row-dense sm:grid-cols-2 sm:gap-3">
      <%= link_to 'Delete',
                  item_path(@item),
                  method: :delete,
                  data: {
                    turbo_method: :delete,
                    action: "modal#close"
                  },
                  class: "btn btn-danger sm:col-start-2" %>
      <button type="button"
              onclick="document.dispatchEvent(new CustomEvent('modal:close:delete-confirm'))"
              class="btn btn-secondary sm:col-start-1">
        Cancel
      </button>
    </div>
  <% end %>
<% end %>
```

### Form Modal
```erb
<%= render ModalComponent.new(
  id: 'new-item-form',
  title: 'Create New Item',
  size: :lg
) do |modal| %>
  <% modal.with_body do %>
    <%= form_with model: @item, data: { controller: "form" } do |f| %>
      <div class="space-y-4">
        <div>
          <%= f.label :name, class: "block text-sm font-medium" %>
          <%= f.text_field :name, class: "mt-1 block w-full rounded-md" %>
        </div>
        
        <div>
          <%= f.label :description, class: "block text-sm font-medium" %>
          <%= f.text_area :description, rows: 4, class: "mt-1 block w-full rounded-md" %>
        </div>
      </div>
    <% end %>
  <% end %>
  
  <% modal.with_actions do %>
    <div class="flex justify-end gap-3">
      <button type="button"
              onclick="document.dispatchEvent(new CustomEvent('modal:close:new-item-form'))"
              class="btn btn-secondary">
        Cancel
      </button>
      <%= f.submit 'Create', class: "btn btn-primary" %>
    </div>
  <% end %>
<% end %>
```

### Success Message Modal
```erb
<%= render ModalComponent.new(
  id: 'success-message',
  title: 'Success!',
  icon: 'check',
  icon_variant: :success
) do |modal| %>
  <% modal.with_body do %>
    <p class="text-sm text-gray-500 text-center">
      Your changes have been saved successfully.
    </p>
  <% end %>
  
  <% modal.with_actions do %>
    <button type="button"
            onclick="document.dispatchEvent(new CustomEvent('modal:close:success-message'))"
            class="w-full btn btn-primary">
      OK
    </button>
  <% end %>
<% end %>
```

## Tips

1. **Unique IDs**: Always use unique IDs for each modal instance
2. **Accessibility**: The component includes proper ARIA attributes
3. **Dark Mode**: Fully supports dark mode out of the box
4. **Animations**: Uses animate.css for smooth transitions
5. **ESC Key**: Press ESC to close the modal
6. **Backdrop Click**: Click outside the modal to close it
7. **Event Naming**: Use descriptive modal IDs for better debugging
