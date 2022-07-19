class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :confirmable, :recoverable

  has_many :subjects, dependent: :destroy
  has_many :exams, dependent: :destroy

  enum role: {admin: 0, user: 1}, _default: 1
  validates :first_name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :last_name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :role, presence: true
end
