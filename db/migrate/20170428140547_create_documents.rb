class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :task
      t.string :name
      t.integer :deleted
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
