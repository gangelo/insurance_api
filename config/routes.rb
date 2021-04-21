require 'constraints/list_with_policies_constraint'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    get '/agents/:id' => 'agents#show', constraints: { id: /\d+/ }
    get '/agents/' => 'agents#list_with_policies', constraints: ListWithPoliciesConstraint.new
  end
end
