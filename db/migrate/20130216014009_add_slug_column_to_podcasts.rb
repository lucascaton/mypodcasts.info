class AddSlugColumnToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :slug, :string

    add_index :podcasts, :slug, unique: true
  end
end
