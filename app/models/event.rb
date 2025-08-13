class Event < ApplicationRecord
  scope :past, -> { where(date < DateTime.now) }
  belongs_to :creator, class_name: 'User'
  has_many :invites, dependent: :destroy
  has_many :attendees, through: :invites, source: :user, dependent: :destroy
end
