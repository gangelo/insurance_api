# frozen_string_literal: true

class AgentsController < ApplicationController
  def show
    agent = Agent.find(params[:id])
    render json: agent.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end
end
