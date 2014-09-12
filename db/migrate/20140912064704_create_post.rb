class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string "url", :limit => 50
    	t.string "title", :limit => 100
    	t.text "description", :limit => 400

    	t.timestamps  
    end
  end
end

