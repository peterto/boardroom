class AddDescriptionToStatuses < ActiveRecord::Migration
  def up
     add_column :statuses, :description, :string

     Status.reset_column_information
   end

   def down
     remove_column :statuses, :description
   end
end
