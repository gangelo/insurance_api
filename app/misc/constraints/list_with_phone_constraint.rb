# frozen_string_literal: true

# Custom constraint for AgentsController#list_with_phone.
# See phone_param_present_and_valid? method for details.
class ListWithPhoneConstraint
  def matches?(request)
    params = request.params
    self.class.phone_param_present_and_valid?(params)
  end

  class << self
    include PhoneNumbers

    # Verifies a valid query string value to find
    # an agent with a given phone number.
    # For example, this method will
    # verify the query string params for:
    # curl http://localhost:3000/api/agents?phone_number=2625296931
    # or
    # curl http://localhost:3000/api/agents?phone_number=12625296931
    def phone_param_present_and_valid?(params)
      phone_number = params[:phone_number]
      phone_valid?(phone_number)
    end
  end
end
