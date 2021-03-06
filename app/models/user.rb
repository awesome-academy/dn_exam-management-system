class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :subjects, dependent: :destroy
  has_many :exams, dependent: :destroy

  enum role: {admin: 0, user: 1} # %i(admin user)
  before_save :downcase_email
  validates :first_name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :last_name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true, length: {
    minimum: Settings.user.email.min_length,
    maximum: Settings.user.email.max_length
  }, format: {with: Settings.user.email.regex_format}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.min_length},
    if: :password, allow_nil: true
  validates :role, presence: true
  has_secure_password
  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_column :remember_digest, nil
  end

  private

  def downcase_email
    email.downcase!
  end
end
