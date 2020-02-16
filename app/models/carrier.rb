# frozen_string_literal: true

class Carrier < ApplicationRecord
  validates :name, presence: true
  has_many :carrier_industries, dependent: :destroy
  has_many :industries, through: :carrier_industries
  has_many :agent_carriers, dependent: :destroy
  has_many :agents, through: :agent_carriers
end
