# frozen_string_literal: true

class AgentPolicy < ApplicationRecord
  belongs_to :agent
  belongs_to :policy, dependent: :destroy
end
