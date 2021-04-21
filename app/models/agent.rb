# frozen_string_literal: true

class Agent < ApplicationRecord
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
end
