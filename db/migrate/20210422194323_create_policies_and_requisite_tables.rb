class CreatePoliciesAndRequisiteTables < ActiveRecord::Migration[6.0]
  def change
    create_table :policies do |t|
      t.string :policy_holder
      t.decimal :premium_amount, precision: 5, scale: 2
      t.references :carrier, foreign_key: true
      t.references :industry, foreign_key: true
      t.timestamps
    end

    create_table :agent_policies do |t|
      t.references :agent, foreign_key: true
      t.references :policy, foreign_key: true
      t.timestamps
    end
  end
end
