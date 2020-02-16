class AddInitialModels < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :phone_number
      t.timestamps
    end

    create_table :licenses do |t|
      t.string :state
      t.references :agent, foreign_key: true
      t.timestamps
    end

    create_table :industries do |t|
      t.string :name
      t.timestamps
    end

    create_table :carriers do |t|
      t.string :name
      t.timestamps
    end

    create_table :carrier_industries, id: false do |t|
      t.references :carrier, foreign_key: true
      t.references :industry, foreign_key: true
    end

    create_table :agent_carriers, id: false do |t|
      t.references :agent, foreign_key: true
      t.references :carrier, foreign_key: true
    end
  end
end
