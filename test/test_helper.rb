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
