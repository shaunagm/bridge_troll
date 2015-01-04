class Chapter < ActiveRecord::Base
  PERMITTED_ATTRIBUTES = [:name, :chapter_description]

  has_many :locations
  has_many :events, -> { where published: true }, through: :locations
  has_and_belongs_to_many :users
  has_many :leaders, through: :chapter_leaderships, source: :user
  has_many :chapter_leaderships

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :chapter_description

  def has_leader?(user)
    return false unless user

    return true if user.admin?

    leaders.include?(user)
  end
end
