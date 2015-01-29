class Survey < ActiveRecord::Base
  PERMITTED_ATTRIBUTES = [:good_things, :bad_things, :other_comments, :rsvp_id, :participate_likelihood, :use_quotes, :want_to_learn]

  belongs_to :rsvp

  validates_presence_of :rsvp_id
  validates_uniqueness_of :rsvp_id, message: "Only one survey response allowed per user."
  validates :participate_likelihood, allow_blank: true, numericality: { only_integer: true, greater_than: 0, less_than: 11 }
end
