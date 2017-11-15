class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :user_send
      t.integer :user_receive

      t.timestamps
    end
  end
end
