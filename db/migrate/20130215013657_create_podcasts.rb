class CreatePodcasts < ActiveRecord::Migration
  def up
    create_table :podcasts do |t|
      t.string :name, null: false
      t.string :feed_url
      t.string :itunes_url
      t.boolean :active, null: false, default: false

      t.timestamps
    end

    add_attachment :podcasts, :logo

    add_index :podcasts, :name,       unique: true
    add_index :podcasts, :feed_url,   unique: true
    add_index :podcasts, :itunes_url, unique: true
  end

  def down
    remove_index :podcasts, column: :name
    remove_index :podcasts, column: :feed_url
    remove_index :podcasts, column: :itunes_url

    remove_attachment :podcasts, :logo

    drop_table :podcasts
  end
end
