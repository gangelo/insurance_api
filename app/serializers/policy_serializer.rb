# frozen_string_literal: true

# Serializes Policy model objects to JSON.
class PolicySerializer < ActiveModel::Serializer
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
    to_json_pretty(attributes) do |json_hash|
      json_hash[:premium_amount] = json_hash[:premium_amount].to_f
      json_hash[:industry] = json_hash[:industry].slice(*id_name_whitelist)
      json_hash[:carrier] = json_hash[:carrier].slice(*id_name_whitelist)
      json_hash[:agent] = json_hash[:agent].slice(*id_name_whitelist)
    end
  end

  def whitelist
    %i[id policy_holder premium_amount industry carrier agent updated_at]
  end

  def id_name_whitelist
    %i[id name]
  end
end
