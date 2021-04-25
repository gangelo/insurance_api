# frozen_string_literal: true

# Module to help retrieve model attribute values and associated
# model objects.
module ModelAssociationOrAttributeValue
  include ModelAssociations

  # If the attribute we need to retrieve is a model association
  # belongs_to, has_one, has_many, etc. we need to get the object
  # using #public_send. If it's simply an attribute, just get the
  # value from the attributes hash.
  def association_or_attribute_value(model, attribute)
    if association? model, attribute
      model.public_send(attribute)
    else
      model.attributes[attribute.to_s]
    end
  end
end
