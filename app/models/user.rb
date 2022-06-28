class User < ApplicationRecord
  has_many :subjects, dependent: :destroy
  has_many :histories, dependent: :destroy

  enum role: {user: 0, admin: 1}, _default: :user
end
