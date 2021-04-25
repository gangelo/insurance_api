# frozen_string_literal: true

class PoliciesController < ApplicationController
  def create
    policy = Policy.create(policy_params_with_agent_id_param)
    if policy.persisted?
      render json: policy, status: :ok
    else
      render json: policy.errors.full_messages.to_json, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "The Policy could not be created because the Agent having id #{agent_id_param[:agent_id]} could not be found" }, status: :not_found
  rescue StandardError
    # If we get here, we have to assume something bad happened.
    render json: { error: 'The Policy could not be created due to an internal server error' }, status: :internal_server_error
  end

  private

  def policy_params_with_agent_id_param
    # Since the Policy model association with Agent is :through :agent_policy, there is no :agent_id attribute on the
    # Policy model; just merge the Agent to associate with the policy in to our params so it can be used in the call to
    # Policy.create.
    policy_params.merge({ agent: Agent.find(agent_id_param[:agent_id]) })
  end

  def policy_params
    params.require(:policy).permit(:policy_holder, :premium_amount, :industry_id, :carrier_id)
  end

  def agent_id_param
    params.permit(:agent_id)
  end
end
