class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :status_id
      t.integer :service_id
      t.date :date
    end
  end
end
