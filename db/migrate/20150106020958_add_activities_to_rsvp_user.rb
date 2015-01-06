class AddActivitiesToRsvpUser < ActiveRecord::Migration
  def change
    add_column :rsvps, :activity_intro, :string
    add_column :rsvps, :activity_tools, :string
    add_column :rsvps, :activity_git, :string
    add_column :rsvps, :activity_panel, :string
    add_column :rsvps, :activity_workshop, :string
  end
end
