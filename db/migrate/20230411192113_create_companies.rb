# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone
      t.string :direction
      t.string :mail, null: false

      t.timestamps
    end
  end
end
