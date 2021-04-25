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
end
