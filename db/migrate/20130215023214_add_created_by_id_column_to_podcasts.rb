class AddCreatedByIdColumnToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :created_by_id, :integer, null: false
  end
end
