class User < ApplicationRecord
  before_create { email.downcase! }
  before_create :set_initial_balance
  validates :username, presence: true, length: { maximum: 15 }, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, on: :create
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def User.digest(string)
    cost = ActiveRecord::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def set_initial_balance
    self.balance = 10000
  end 
end
