class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :author
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
