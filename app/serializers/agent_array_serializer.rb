# frozen_string_literal: true

# Serializes lists of Agent model objects to JSON.
class AgentArraySerializer < ActiveModel::ArraySerializer
  include PrettySerializable

  self.root = false

  def to_json(_params)
    to_json_pretty(object.map(&:attributes))
  end
end
