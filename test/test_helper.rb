# frozen_string_literal: true

require 'simplecov'
SimpleCov.start('rails') do
  track_files '{app,lib}/**/*.rb'
end
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests
  # in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# Creates a mock http request object. Call example:
# request = request(state: 'OH', industry: 'Industry')
# => #<OpenStruct params={:state => 'OH', :industry => 'Industry'}>
# request.params
# => { :state => 'OH', :industry => 'Industry' }
def request(params)
  OpenStruct.new(params: {}).tap do |o|
    o.params.merge!(params)
  end
end

# Returns a new, valid policy for the agent with
# the given name. Carrier and Industry are
# randomly selected.
def policy_for(agent_name, attributes = {})
  agent = Agent.find_by(name: agent_name)
  raise "Agent with the name #{agent_name} could not be found" if agent.blank?

  carrier, industry = valid_carrier_and_industry_for(agent)
  policy_attributes = {
    policy_holder: 'Sam I Am',
    premium_amount: 100.00,
    agent: agent,
    carrier: carrier,
    industry: industry
  }.merge(attributes)

  yield policy_attributes if block_given?

  Policy.new(policy_attributes)
end

# Returns a valid carrier for the agent,
# and a valid industry for the carrier.
def valid_carrier_and_industry_for(agent)
  # Use #find so we raise an error if no
  # carrier or industry is available.
  carrier = Carrier.find(agent.carrier_ids.sample)
  industry = Industry.find(carrier.industry_ids.sample)
  [carrier, industry]
end

# Returns a carrier that the agent does
# not work with.
def invalid_carrier_for(agent)
  Carrier.where.not(id: agent.carrier_ids).sample
end

# Returns an industry that is incompatible with
# any carrier industry the agent works with.
def invalid_industry_for(agent)
  # We can't just choose industries from carriers
  # that the agent DOESN'T work with, because
  # multiple carriers can use the same industry.
  # It's safer to just choose an industry that
  # the agent cannot work in, irrespective of
  # the carrier.
  industry_ids = agent.carriers.map(&:industry_ids).flatten.uniq
  Industry.where.not(id: industry_ids).sample
end
