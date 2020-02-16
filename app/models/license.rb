# frozen_string_literal: true

class License < ApplicationRecord
  validates :state, presence: true
  belongs_to :agent
end
