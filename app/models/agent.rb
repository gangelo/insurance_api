# frozen_string_literal: true

class Agent < ApplicationRecord
  validates :name, :phone_number, presence: true
  has_many :licenses, dependent: :destroy
  has_many :agent_carriers, dependent: :destroy
  has_many :carriers, through: :agent_carriers
end
