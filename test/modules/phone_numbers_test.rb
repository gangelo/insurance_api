# frozen_string_literal: true

require 'test_helper'

class PhoneNumbersTest < ActiveSupport::TestCase
  test '.raw_phone_number_from returns the raw phone number if the phone number is valid' do
    assert '12223334444', PhoneNumbers.raw_phone_number_from('(222) 333-4444')
    assert '12223334444', PhoneNumbers.raw_phone_number_from('1-222-333-4444')
    assert '12223334444', PhoneNumbers.raw_phone_number_from('222-333-4444')
    assert '12223334444', PhoneNumbers.raw_phone_number_from('222.333.4444')
  end

  test '.raw_phone_number_from raises an error if the phone number cannot be converted' do
    assert_raises(StandardError) { PhoneNumbers.raw_phone_number_from(nil) }
    assert_raises(StandardError) { PhoneNumbers.raw_phone_number_from(' ') }
    assert_raises(StandardError) { PhoneNumbers.raw_phone_number_from('A123456789') }
    assert_raises(StandardError) { PhoneNumbers.raw_phone_number_from('012345678901A') }
  end

  test '.normalize_phone returns the normalized phone number' do
    assert_equal '12223334444', PhoneNumbers.normalize_phone('2223334444')
    assert_equal '12223334444', PhoneNumbers.normalize_phone('12223334444')
  end

  test '.normalize_phone raises an error if phone number is invalid' do
    assert_raises(ArgumentError) { PhoneNumbers.normalize_phone(' ') }
    assert_raises(ArgumentError) { PhoneNumbers.normalize_phone(nil) }
    assert_raises(ArgumentError) { PhoneNumbers.normalize_phone('012345678') }
    assert_raises(ArgumentError) { PhoneNumbers.normalize_phone('012345678912') }
  end

  test '.phone_valid? returns true if the phone number is valid' do
    assert PhoneNumbers.phone_valid?('2223334444')
    assert PhoneNumbers.phone_valid?('12223334444')
  end

  test '.phone_valid? returns false if the phone number is invalid' do
    assert_not PhoneNumbers.phone_valid?('223334444')
    assert_not PhoneNumbers.phone_valid?(' ')
    assert_not PhoneNumbers.phone_valid?(nil)
    assert_not PhoneNumbers.phone_valid?('22X3334444')
  end
end
