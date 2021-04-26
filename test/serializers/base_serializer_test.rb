# frozen_string_literal: true

require 'test_helper'

class BaseSerializerTest < ActiveSupport::TestCase
  test '#as_json returns the a hash with the id' do
    agent = Agent.find_by(name: 'Gene Angelo')
    serializer = BaseSerializer.new(agent)

    actual = serializer.as_json(root: false)

    assert_kind_of Hash, actual
    assert_equal agent.id, actual[:id]
  end

  test '#to_json returns the a JSON string with the id' do
    agent = Agent.find_by(name: 'Gene Angelo')
    serializer = BaseSerializer.new(agent)

    actual = serializer.to_json(root: false)

    assert_kind_of String, actual
    assert_equal agent.id, JSON.parse(actual)['id']
  end

  test '#to_json returns the a beautified JSON string with the id' do
    agent = Agent.find_by(name: 'Gene Angelo')
    serializer = BaseSerializer.new(agent)

    actual = serializer.to_json(root: false)

    assert_equal agent.id, JSON.parse(actual)['id']
    assert actual.include? "\n"
  end
end
