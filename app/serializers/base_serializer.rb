# frozen_string_literal: true

# Base for classes deriving from ActiveModel::Serializer.
class BaseSerializer < ActiveModel::Serializer
  include PrettySerializable

  attributes :id

  AS_JSON_OPTIONS = %i[only except].freeze

  def to_json(_params)
    to_json_pretty(attributes)
  end

  def as_json(options = {})
    # If we simply call super with no options, the attributes
    # defined take presidence. This allows us to use some
    # of the other normal as_json options like :only, :except.
    return super.as_json(options) if as_json_options? options
    super
  end

  def as_json_options?(options)
    options.keys.any? { |key| AS_JSON_OPTIONS.include? key }
  end
end
