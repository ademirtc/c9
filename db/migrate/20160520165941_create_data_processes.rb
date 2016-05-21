class CreateDataProcesses < ActiveRecord::Migration
  def change
    create_table :data_processes do |t|

      t.timestamps null: false
    end
  end
end
