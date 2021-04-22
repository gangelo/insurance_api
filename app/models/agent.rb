# frozen_string_literal: true

require 'modules/phone_numbers'

class Agent < ApplicationRecord
  include PhoneNumbers

  validates :name, :phone_number, presence: true
  has_many :licenses, dependent: :destroy
  has_many :agent_carriers, dependent: :destroy
  has_many :carriers, through: :agent_carriers

  scope :with_policies_in_industry, lambda \
     { |state, industry|
       joins(:licenses, carriers: :industries)
         .where("'licenses'.'state' = :state AND 'industries'.'name' = :industry",
           state: state.upcase, industry: industry).distinct
     }

  scope :with_phone_number, lambda \
    { |phone_number|
      where('match_phone_number(phone_number, :phone_number)', phone_number: phone_number)
    }
end
