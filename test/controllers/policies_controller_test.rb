# frozen_string_literal: true

require 'test_helper'

class PoliciesControllerTest < ActionDispatch::IntegrationTest
  # POST /api/policies
  test 'Returns :ok creates a Policy when the policy is valid and issuable' do
    agent = Agent.find_by(name: 'Gemma Ritchie')
    carrier, industry = valid_carrier_and_industry_for(agent)

    post '/api/policies/', params: {
      agent_id: agent.id,
      policy: {
        policy_holder: 'Sam I Am',
        premium_amount: 1.00,
        industry_id: industry.id,
        carrier_id: carrier.id
      }
    }

    assert_response :ok

    json = JSON.parse(response.body)
    assert_equal 'Sam I Am', json['policy_holder']
    assert_not_nil json['carrier']
    assert_not_nil json['industry']
    assert_not_nil json['agent']
  end

  test 'Returns :bad_request if the policy cannot be persisted' do
    agent = Agent.find_by(name: 'Gemma Ritchie')
    _, industry = valid_carrier_and_industry_for(agent)
    carrier = invalid_carrier_for(agent)

    post '/api/policies/', params: {
      agent_id: agent.id,
      policy: {
        policy_holder: 'Sam I Am',
        premium_amount: 1.00,
        industry_id: industry.id,
        carrier_id: carrier.id
      }
    }

    assert_response :bad_request

    json = JSON.parse(response.body)
    assert_equal ['Policy must be issuable'], json
  end

  test 'Returns :not_found if the agent cannot be found' do
    agent = Agent.find_by(name: 'Gemma Ritchie')
    carrier, industry = valid_carrier_and_industry_for(agent)

    post '/api/policies/', params: {
      agent_id: 9_999_999_999_999_999,
      policy: {
        policy_holder: 'Sam I Am',
        premium_amount: 1.00,
        industry_id: industry.id,
        carrier_id: carrier.id
      }
    }

    assert_response :not_found

    json = JSON.parse(response.body)
    assert_equal 'The Policy could not be created because the Agent having id 9999999999999999 could not be found', json['error']
  end

  test 'Returns :internal_server_error if an internal server error occurs and the policy cannot be created' do
    agent = Agent.find_by(name: 'Gemma Ritchie')
    carrier, industry = valid_carrier_and_industry_for(agent)

    post '/api/policies/', params: {
      agent_id: agent.id,
      # This will cause the 500
      oops_policy: {
        policy_holder: 'Sam I Am',
        premium_amount: 1.00,
        industry_id: industry.id,
        carrier_id: carrier.id
      }
    }

    assert_response :internal_server_error

    json = JSON.parse(response.body)
    assert_equal 'The Policy could not be created due to an internal server error', json['error']
  end
end
