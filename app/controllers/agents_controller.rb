# frozen_string_literal: true

class AgentsController < ApplicationController
  before_action :agents_with_policies, only: :list_with_policies
  before_action :agents_with_phone, only: :list_with_phone

  def show
    agent = Agent.find(params[:id])
    render json: agent.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  def list_with_policies
    if agents_with_policies.present?
      render json: agents_with_policies.to_json, status: :ok
    else
      render json: [], status: :not_found
    end
  end

  def list_with_phone
    if agents_with_phone.present?
      render json: agents_with_phone.to_json, status: :ok
    else
      render json: [], status: :not_found
    end
  end

  private

  def agents_with_policies
    @agents_with_policies ||= Agent.with_policies_in_industry(params[:state], params[:industry])
  end

  def agents_with_phone
    @agents_with_phone ||= Agent.with_phone_number(params[:phone_number])
  end
end
