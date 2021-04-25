# frozen_string_literal: true

# Serializes Agent model objects to JSON.
class AgentSerializer < ActiveModel::Serializer
  include PrettySerializable
  include ModelAssociationOrAttributeValue

  def attributes(*args)
    super.tap do |hash|
      whitelist.each do |attribute|
        hash[attribute] = association_or_attribute_value object, attribute
      end
    end
  end

  def to_json(_params)
    to_json_pretty(attributes)
  end

  def whitelist
    %i[id name phone_number created_at updated_at]
  end
end
