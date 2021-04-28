# frozen_string_literal: true

# Serializes Policy model objects to JSON.
class PolicySerializer < BaseSerializer
  attributes :id, :policy_holder, :premium_amount, :industry, :carrier, :agent, :updated_at

  def to_json(_params)
    to_json_pretty(attributes) do |json_hash|
      json_hash[:premium_amount] = json_hash[:premium_amount].to_f
    end
  end

  def agent_seriaizer_options
    common_serializer_options
  end

  def carrier_seriaizer_options
    common_serializer_options
  end

  def industry_seriaizer_options
    common_serializer_options
  end

  def common_serializer_options
    @common_serializer_options ||= { root: false, only: %i[id name] }
  end

  private

  def agent
    AgentSerializer.new(object.agent).as_json agent_seriaizer_options
  end

  def carrier
    CarrierSerializer.new(object.carrier).as_json carrier_seriaizer_options
  end

  def industry
    IndustrySerializer.new(object.industry).as_json industry_seriaizer_options
  end
end
