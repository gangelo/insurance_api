# frozen_string_literal: true

class ApplicationController < ActionController::API
  # Makes sure /app/serializers are used.
  include ActionController::Serialization

  # Flagged by rails_best_practices as unused, but it's being used by ActiveModel::Serializers to remove the
  # root node in my serializers by default.
  # https://www.rubydoc.info/gems/active_model_serializers/0.9.1#2-disable-root-per-render-call-in-your-controller
  def default_serializer_options
    { root: false }
  end
end
