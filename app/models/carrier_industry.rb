# frozen_string_literal: true

class CarrierIndustry < ApplicationRecord
  belongs_to :carrier
  belongs_to :industry
end
