class ChangeStringsToText < ActiveRecord::Migration
  def change
	change_column :chapters, :chapter_description, :text, :limit => nil
	change_column :rsvps, :potential_projects, :text, :limit => nil
	change_column :rsvps, :availability_info, :text, :limit => nil
	change_column :rsvps, :volunteer_projects, :text, :limit => nil
  end
end
