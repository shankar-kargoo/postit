class Comments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.text "comment", :limit => 140
  		t.integer "user_id"
  		t.integer "post_id"

    	t.timestamps  
  	end
  end
end

