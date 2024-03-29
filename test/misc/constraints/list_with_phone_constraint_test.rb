# frozen_string_literal: true

require 'test_helper'

class ListWithPhoneConstraintTest < ActiveSupport::TestCase
  test '#matches? returns true when the correct params are present and valid' do
    subject = ListWithPhoneConstraint.new
    actual = subject.matches?(request(phone_number: '2223334444'))
    assert actual

    actual = subject.matches?(request(phone_number: '12223334444'))
    assert actual
  end

  test '#matches? returns false when phone_number is not valid' do
    subject = ListWithPhoneConstraint.new
    actual = subject.matches?(request(phone_number: ' '))
    assert_not actual

    actual = subject.matches?(request(phone_number: '122X3334444'))
    assert_not actual

    actual = subject.matches?(request(phone_number: '012345678'))
    assert_not actual

    actual = subject.matches?(request(phone_number: '012345678901'))
    assert_not actual
  end

  test '.phone_param_present_and_valid? returns true when the correct param is present and valid' do
    actual = ListWithPhoneConstraint.phone_param_present_and_valid?(request(phone_number: '12223334444').params)
    assert actual

    actual = ListWithPhoneConstraint.phone_param_present_and_valid?(request(phone_number: '2223334444').params)
    assert actual
  end

  test '.phone_param_present_and_valid? returns false when the correct param is not present or valid' do
    actual = ListWithPhoneConstraint.phone_param_present_and_valid?(request(phone_number: ' ').params)
    assert_not actual

    actual = ListWithPhoneConstraint.phone_param_present_and_valid?(request(phone_number: '222X334444').params)
    assert_not actual

    actual = ListWithPhoneConstraint.phone_param_present_and_valid?(request(phone_number: '012345678').params)
    assert_not actual

    actual = ListWithPhoneConstraint.phone_param_present_and_valid?(request(phone_number: '012345678912').params)
    assert_not actual
  end
end
