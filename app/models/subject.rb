class Subject < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  enum status: {inactive: 0, active: 1}
end
