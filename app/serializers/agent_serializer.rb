# frozen_string_literal: true

# Serializes Agent model objects to JSON.
class AgentSerializer < BaseSerializer
  attributes :id, :name, :phone_number, :created_at, :updated_at
end
