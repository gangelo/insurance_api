# frozen_string_literal: true

class Policy < ApplicationRecord
  include PolicyIssuable

  validate :must_be_issuable
  validates :policy_holder, :premium_amount, presence: true
  # Policies are cheap these days...
  validates :premium_amount, numericality: { greater_than_or_equal_to: 0.01 }
  validates :agent, :carrier, :industry, presence: true

  has_one :agent_policy, dependent: :destroy
  has_one :agent, through: :agent_policy
  belongs_to :carrier
  belongs_to :industry

  # TODO: Prevent non-unique policies? I assume
  # you can have more than one of the same policy?
  # Perhaps the same policy holder can have, say,
  # more than one policy in the same industry
  # (i.e. multiple companies within the same
  # industry?)

  # This method is NOT a replacement for validate, but is used IAW validate.
  # This method simply returns true or false depending on whether or not
  # the agent can issue a policy for the industry, through the given carried.
  def policy_issuable?
    return false unless agent && carrier_id? && industry_id?

    self.class.policy_issuable? agent_id: agent.id, carrier_id: carrier_id, industry_id: industry_id
  end

  private

  def must_be_issuable
    errors.add(:policy, 'must be issuable') unless policy_issuable?
  end
end
