class AddFieldsToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :preevent_contact, :boolean
    add_column :rsvps, :potential_projects, :string
  end
end
