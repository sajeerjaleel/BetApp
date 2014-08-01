class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
    	t.belongs_to :league
      t.belongs_to :user
      t.boolean :new
      t.timestamps
    end
  end
end
