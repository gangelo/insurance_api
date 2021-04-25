# frozen_string_literal: true

require 'test_helper'

class PolicyTest < ActiveSupport::TestCase
  test 'validates policy_holder is present' do
    policy = policy_for('Gene Angelo', policy_holder: '')
    assert_not policy.valid?
  end

  test 'validates premium_amount is present' do
    policy = policy_for('Amy Angelo', premium_amount: nil)
    assert_not policy.valid?
  end

  test 'validates premium_amount is >= 0.01' do
    policy = policy_for('Amy Angelo', premium_amount: 0)
    assert_not policy.valid?

    policy.premium_amount = 0.01
    assert policy.valid?
  end

  test 'validates agent is present' do
    policy = policy_for('Daniel Angelo') { |attrs| attrs[:agent] = nil }
    assert_not policy.valid?
  end

  test 'validates carrier is present' do
    policy = policy_for('Elijah Angelo') { |attrs| attrs[:carrier] = nil }
    assert_not policy.valid?
  end

  test 'validates industry is present' do
    policy = policy_for('Ericka Yost') { |attrs| attrs[:industry] = nil }
    assert_not policy.valid?
  end

  test "validates the policy won't be issued if the agent doesn't work with the carrier" do
    policy = policy_for('Gemma Ritchie') do |attrs|
      attrs[:carrier] = invalid_carrier_for(attrs[:agent])
    end
    assert_not policy.valid?
  end

  test "validates the policy won't be issued if the agent doesn't work with the carrier industry" do
    policy = policy_for('Gemma Ritchie') do |attrs|
      attrs[:industry] = invalid_industry_for(attrs[:agent])
    end
    assert_not policy.valid?
  end

  test 'validates when all validations pass' do
    policy = policy_for('Ericka Yost')
    assert policy.valid?
  end
end
