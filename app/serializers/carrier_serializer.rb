# frozen_string_literal: true

# Serializes Agent model objects to JSON.
class CarrierSerializer < BaseSerializer
  attributes :id, :name, :created_at, :updated_at
end
