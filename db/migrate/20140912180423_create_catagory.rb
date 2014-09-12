class CreateCatagory < ActiveRecord::Migration
  def change
    create_table :catagories do |t|
    	t.string "catagory"
    	t.timestamps
    end
  end
end
