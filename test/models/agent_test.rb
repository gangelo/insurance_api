# frozen_string_literal: true

require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  test 'should validate name is present' do
    agent = Agent.new(name: nil, phone_number: '(614) 999-9999')
    assert_not agent.valid?
  end

  test 'should validate phone number is present' do
    agent = Agent.new(name: 'Perry Penguin', phone_number: nil)
    assert_not agent.valid?
  end

  test 'should be valid when both name and phone number are present' do
    agent = Agent.new(
      name: 'Perry Penguin',
      phone_number: '(614) 999-9999'
    )
    assert agent.valid?
  end

  test 'James should be licensed in OH and KY' do
    james = Agent.find_by(name: 'James Willhelm')
    assert james.licenses.where(state: 'OH').any?
    assert james.licenses.where(state: 'KY').any?
    assert_equal 2, james.licenses.size
  end

  test 'Gemma should work with Big City and Omaha' do
    gemma = Agent.find_by(name: 'Gemma Ritchie')
    assert gemma.carriers.where(name: 'Big City Mutual Insurance').any?
    assert gemma.carriers.where(name: 'Omaha Insurance Company').any?
    assert_equal 2, gemma.carriers.size
  end

  test 'Gene Angelo should work with Big City' do
    agent = Agent.find_by(name: 'Gene Angelo')
    assert agent.carriers.where(name: 'Big City Mutual Insurance').any?
    assert_equal 1, agent.carriers.size
  end

  test 'Amy Angelo should work with Big City' do
    agent = Agent.find_by(name: 'Amy Angelo')
    assert agent.carriers.where(name: 'Big City Mutual Insurance').any?
    assert_equal 1, agent.carriers.size
  end

  test 'Daniel Angelo should work with Big City' do
    agent = Agent.find_by(name: 'Daniel Angelo')
    assert agent.carriers.where(name: 'Big City Mutual Insurance').any?
    assert_equal 1, agent.carriers.size
  end

  test 'Elijah Angelo should work with Big City' do
    agent = Agent.find_by(name: 'Elijah Angelo')
    assert agent.carriers.where(name: 'Big City Mutual Insurance').any?
    assert_equal 1, agent.carriers.size
  end

  test 'scope with_phone_number should return agents with the given phone number' do
    agents = Agent.with_phone_number('2223334444')
    assert_equal agents.count, 4
    assert_includes agents, Agent.find_by(name: 'Gene Angelo')
    assert_includes agents, Agent.find_by(name: 'Amy Angelo')
    assert_includes agents, Agent.find_by(name: 'Daniel Angelo')
    assert_includes agents, Agent.find_by(name: 'Elijah Angelo')
  end
end
