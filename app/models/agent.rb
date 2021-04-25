# frozen_string_literal: true

class Agent < ApplicationRecord
  include PolicyIssuable
  include PhoneNumbers

  validates :name, :phone_number, presence: true
  has_many :licenses, dependent: :destroy
  has_many :agent_carriers, dependent: :destroy
  has_many :carriers, through: :agent_carriers
  has_many :agent_policies, dependent: :destroy
  has_many :policies, through: :agent_policies

  # Returns agents licensed in the given state that work
  # with carriers that sell policies for the given industry.
  scope :with_policies_in_industry, lambda \
     { |state, industry|
       joins(:licenses, carriers: :industries)
         .where("'licenses'.'state' = :state AND 'industries'.'name' = :industry",
           state: state.upcase, industry: industry).distinct
     }

  # Returns agents having the phone number provided using a user defined function.
  # See config/initializers/database_functions.rb
  scope :with_phone_number, lambda \
    { |phone_number|
      where('match_phone_number(phone_number, :phone_number)', phone_number: phone_number)
    }
end
