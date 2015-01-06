class AddDefaultToChapterDescription < ActiveRecord::Migration
  def change
    change_column_default :chapters, :chapter_description, ""
  end
end
