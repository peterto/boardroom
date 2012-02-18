class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :message
      t.integer :service_id
      t.integer :status_id

      t.timestamps
    end
  end
end
