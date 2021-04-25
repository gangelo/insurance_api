# frozen_string_literal: true

# This module helps with handling the inconsistent phone number formats
# in the database (e.g. Agent#phone_number)
module PhoneNumbers
  PHONE_NUMBER_RAW_REGEX = /([[:digit:]])?[-. ]?\(?([[:digit:]]{3})\)?[-. ]([[:digit:]]{3})[-.]([[:digit:]]{4})/.freeze

  module_function

  # Takes a phone number having variable formats and returns
  # the normalized, raw, phone number e.g.
  # 1-222-333-4444
  # 222.333.4444
  # 222-333-4444
  # (222) 333-4444
  # => 12223334444
  def raw_phone_number_from(phone_number)
    return normalize_phone(phone_number) if phone_valid?(phone_number)

    matches = PHONE_NUMBER_RAW_REGEX.match(phone_number)
    normalize_phone(matches.captures[1..].join)
  rescue StandardError => e
    raise "Could not convert phone_number #{phone_number} to raw format #{e.message}"
  end

  # Normalizes a phone number by ensuring the +1 dial code e.g.
  # 2223334444
  # 12223334444
  # => 12223334444
  #
  # Since the assignment instructions assume
  # curl http://localhost:3000/api/agents?phone_number=2625296931
  # and
  # curl http://localhost:3000/api/agents?phone_number=12625296931
  # should both return agents having a phone number assumed to
  # have a United States dial code (+1) (not to mention License#state),
  # We'll assume all dial codes to be +1 and normalize all phone numbers
  # as such for our phone number queries.
  def normalize_phone(phone_number)
    raise ArgumentError, "phone_number #{phone_number} is not valid" \
      unless phone_valid?(phone_number)

    phone_number = phone_number.to_s
    if phone_number.length == 10
      "1#{phone_number}"
    else
      phone_number
    end
  end

  # Returns true if phone_number is a 10 or 11 digit
  # phone number, false otherwise e.g.
  # 2223334444
  # 12223334444
  # => true
  def phone_valid?(phone_number)
    return false if phone_number.blank?

    # Phone numbers coming in should have 10
    # or 11 digits (if the dial code is provided).
    /\A[[:digit:]]{10,11}\z/.match?(phone_number)
  end
end
