class AddDescriptionToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :chapter_description, :string
  end
end
