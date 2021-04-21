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

  # GET /api/agents?state=<state>&industry=<industry>
  test 'Returns :ok and a list of Agent JSON objects if Agents are found selling policies for the given industry in the given state' do
    get '/api/agents?state=KY&industry=Underwater welding'

    assert_response :ok

    json = JSON.parse(response.body)
    assert_not_empty json

    actual = json.each.map { |h| h['id'] }
    expected = [451_584_698, 129_232_768]

    assert_equal actual.count, expected.count
    assert_includes actual, expected[0]
    assert_includes actual, expected[1]
  end

  test 'Returns :not_found and an empty JSON array when no Agents are returned' do
    get '/api/agents?state=XX&industry=Not%20Found'

    assert_response :not_found

    json = JSON.parse(response.body)
    assert_equal json, []
  end
end
