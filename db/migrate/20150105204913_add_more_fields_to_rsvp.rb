class AddMoreFieldsToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :availability, :boolean
    add_column :rsvps, :availability_info, :string
    add_column :rsvps, :volunteer_training, :string
    add_column :rsvps, :volunteer_projects, :string
  end
end
