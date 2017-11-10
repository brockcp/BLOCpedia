class User < ApplicationRecord
  after_initialize { self.role ||= :standard }
  has_many :wikis, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  enum role: [:standard, :premium, :admin]
end
