class Wiki < ApplicationRecord
  belongs_to :user

  has_many :collaborators
  has_many :collaborating_users, through: :collaborators, source: :user

  attr_accessor :collaborating_user_ids

end
