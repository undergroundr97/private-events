class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id'
  has_many :invites
  has_many :attending_events, through: :invites, source: :event
end
