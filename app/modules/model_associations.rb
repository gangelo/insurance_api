# frozen_string_literal: true

# Module to help retrieve ActiveRecord model attribute values
# and associated model objects.
module ModelAssociations
  def association?(model, attribute)
    all_associations(model).include? attribute
  end

  def all_associations(model)
    @all_associations ||= model.class.reflect_on_all_associations.map(&:name)
  end
end
