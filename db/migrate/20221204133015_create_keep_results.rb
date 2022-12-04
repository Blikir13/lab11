# frozen_string_literal: true

class CreateKeepResults < ActiveRecord::Migration[7.0]
  def change
    create_table :keep_results do |t|
      t.string :input
      t.string :result

      t.timestamps
    end
  end
end
