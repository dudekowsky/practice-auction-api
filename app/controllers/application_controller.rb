# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from StandardError, with: :render_bad_request
  def render_not_found
    head :not_found
  end

  def render_bad_request
    head :bad_request
  end
end
