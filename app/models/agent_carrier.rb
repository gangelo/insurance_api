# frozen_string_literal: true

class AgentCarrier < ApplicationRecord
  belongs_to :agent
  belongs_to :carrier
end
