# frozen_string_literal: true

# Custom constraint for AgentsController#list_with_policies.
# See X...X_param_present_and_valid? methods for details.
class ListWithPoliciesConstraint
  def matches?(request)
    params = request.params
    self.class.state_param_present_and_valid?(params) &&
      self.class.industry_param_present_and_valid?(params)
  end

  class << self
    # The below methods verify the query string values to
    # find agents able to sell policies in the given state,
    # for the given industry. For example, this method will
    # verify the query string params for:
    # curl -X GET http://localhost:3000/api/agents
    #   -d state=OH -d industry="Professional Beer Taste-Tester"

    def state_param_present_and_valid?(params)
      state = params[:state]
      return false if state.blank?

      # Check the state for 2 alpha characters, no
      # need to go crazy.
      /\A[[:alpha:]]{2}\z/.match?(state)
    end

    def industry_param_present_and_valid?(params)
      # Just check for present? If present?, we know we have
      # something worth querying.
      params[:industry].present?
    end
  end
end
