# frozen_string_literal: true

class Industry < ApplicationRecord
  validates :name, presence: true
  has_many :carrier_industries, dependent: :destroy
  has_many :carriers, through: :carrier_industries
end
