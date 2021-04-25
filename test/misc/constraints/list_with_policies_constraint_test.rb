# frozen_string_literal: true

require 'test_helper'

class ListWithPoliciesConstraintTest < ActiveSupport::TestCase
  test '#matches? returns true when the correct params are present and valid' do
    subject = ListWithPoliciesConstraint.new
    actual = subject.matches?(request(state: 'OH', industry: 'Industry'))
    assert actual
  end

  test '#matches? returns false when state is not valid' do
    subject = ListWithPoliciesConstraint.new
    actual = subject.matches?(request(state: 'XXX', industry: 'Industry'))
    assert_not actual
  end

  test '#matches? returns false when state is not present' do
    subject = ListWithPoliciesConstraint.new
    actual = subject.matches?(request(state: '', industry: 'Industry'))
    assert_not actual

    actual = subject.matches?(request(industry: 'Industry'))
    assert_not actual
  end

  test '#matches? returns false when industry is not present' do
    subject = ListWithPoliciesConstraint.new
    actual = subject.matches?(request(state: 'NJ', industry: ' '))
    assert_not actual

    actual = subject.matches?(request(state: 'NJ'))
    assert_not actual
  end

  test '.state_param_present_and_valid? returns true when the correct param is present and valid' do
    actual = ListWithPoliciesConstraint.state_param_present_and_valid?(request(state: 'NJ').params)
    assert actual
  end

  test '.state_param_present_and_valid? returns false when state is not valid' do
    actual = ListWithPoliciesConstraint.state_param_present_and_valid?(request(state: 'XXX').params)
    assert_not actual
  end

  test '.state_param_present_and_valid? returns false when state is not present' do
    actual = ListWithPoliciesConstraint.state_param_present_and_valid?(request(state: ' ').params)
    assert_not actual

    actual = ListWithPoliciesConstraint.state_param_present_and_valid?(request({}).params)
    assert_not actual
  end

  test '.industry_param_present_and_valid? returns true when the correct param is present and valid' do
    actual = ListWithPoliciesConstraint.industry_param_present_and_valid?(request(industry: 'Industry').params)
    assert actual
  end

  test '.industry_param_present_and_valid? returns false when industry is not present' do
    actual = ListWithPoliciesConstraint.industry_param_present_and_valid?(request(industry: ' ').params)
    assert_not actual

    actual = ListWithPoliciesConstraint.industry_param_present_and_valid?(request({}).params)
    assert_not actual
  end
end
