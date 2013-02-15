class AddOverviewColumnToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :overview, :text
  end
end
