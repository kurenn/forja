# frozen_string_literal: true

module DesignSystem
  class BaseController < ApplicationController
    layout "design_system/application"

    before_action :ensure_development_environment

    private

    def ensure_development_environment
      raise ActionController::RoutingError, "Not Found" unless Rails.env.development?
    end
  end
end
