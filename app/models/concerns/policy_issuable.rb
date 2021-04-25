# frozen_string_literal: true

module PolicyIssuable
  extend ActiveSupport::Concern

  module ClassMethods
    # Returns true if a policy can be issued to the agent
    # for the industry, through the given carrier. Call this
    # as a validation. However, this should NOT be used as a
    # replacement for validate in the model, but should be used
    # IAW validate in the model.
    #
    # This method simply returns true or false depending on
    # whether or not the agent can issue a policy for the
    # industry, through the given carried.
    def policy_issuable?(agent_id:, carrier_id:, industry_id:)
      AgentCarrier
        .joins(carrier: [:industries])
        .where(agent_id: agent_id,
          carriers: { id: carrier_id },
          industries: { id: industry_id })
        .exists?
    end
  end
end
