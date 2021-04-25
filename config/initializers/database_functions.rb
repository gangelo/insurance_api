# Credit: https://www.marksayson.com/blog/enabling_regular_expressions_in_sqlite_with_rails/
ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
  alias_method :orig_initialize, :initialize

  # Extend database initialization to add our own functions
  def initialize(connection, logger = nil, pool = nil)
    orig_initialize(connection, logger, pool)

    # Initializer for SQLite3 databases
    if connection.is_a? SQLite3::Database
      # Adds an SQLite3 user function to match on inconsistent
      # phone number formatting in the database (i.e. agents.phone_number).
      # db_phone_number is normalized to an 11-digit phone
      # number and compared against phone_number_to_match after
      # it, too, has been normalized for comparison.
      connection.create_function('match_phone_number', 2) do |fn, db_phone_number, phone_number_to_match|
        matches = PhoneNumbers::PHONE_NUMBER_RAW_REGEX.match(db_phone_number)
        db_phone_number_normalized = PhoneNumbers.normalize_phone(matches.captures[1..].join)
        fn.result = db_phone_number_normalized == PhoneNumbers.normalize_phone(phone_number_to_match) ? 1 : 0
      end
    end
  end
end
