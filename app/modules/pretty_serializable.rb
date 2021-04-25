# frozen_string_literal: true

# Generates beautified JSON given a hash of model attributes.
# Used by the model serializers in the controller actions to
# render formatted JSON.
module PrettySerializable
  JSON_OPTIONS = {
    array_nl: "\n",
    object_nl: "\n",
    indent: '  '
  }.freeze

  # Call this method from your #to_json method. attributes is a hash of model
  # attributes (or an array of model attributes) to generate the JSON. Customizations
  # to the JSON hash can be made prior to generating the JSON by passing a block
  # to this method.
  # rubocop:disable Style/OptionHash - prefer options hash in this case in order to Hash#merge
  def to_json_pretty(attributes, options = {})
    raise 'Argument attributes must respond_to? #as_json' unless attributes.respond_to? :as_json

    # Better than trying to duck-type Hash vs. Arrays :S
    json_hash = if attributes.is_a? Hash
      attributes.as_json.with_indifferent_access.tap do |hash|
        yield hash if block_given?
      end
    else
      attributes.map do |attrs|
        attrs.as_json.with_indifferent_access.tap do |hash|
          yield hash if block_given?
        end
      end
    end
    JSON.generate json_hash, JSON_OPTIONS.merge(options)
  end
  # rubocop:enable Style/OptionHash
end
