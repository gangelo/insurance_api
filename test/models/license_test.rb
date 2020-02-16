# frozen_string_literal: true

require 'test_helper'

class LicenseTest < ActiveSupport::TestCase
  test 'should validate state is present' do
    license = License.new(state: nil)
    assert_not license.valid?
  end
end
