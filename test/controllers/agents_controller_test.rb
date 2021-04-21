# frozen_string_literal: true

require 'test_helper'

class AgentsControllerTest < ActionDispatch::IntegrationTest
  # GET /api/agents/:id
  test 'Returns :ok and the Agent JSON when the Agent is found' do
    agent = Agent.new(
      name: 'Perry Penguin',
      phone_number: '(614) 999-9999'
    )
    assert agent.valid?
    assert agent.save

    get "/api/agents/#{agent.id}"

    assert_response :ok

    json = JSON.parse(response.body)
    assert_equal agent.id, json['id']
  end

  test 'Returns :not_found and an empty JSON object when the Agent is not found' do
    get '/api/agents/0'

    assert_response :not_found

    json = JSON.parse(response.body)
    assert_empty json
  end
end
