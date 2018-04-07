class User < ApplicationRecord
  attr_accessor :remember_token
  before_create { email.downcase! }
  before_create :set_initial_balance
  validates :username, presence: true, length: { maximum: 15 }, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, on: :create
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_many :messages
  has_many :friend_requests, dependent: :destroy
  has_and_belongs_to_many :friendships,
    class_name: 'User',
    join_table: :friendships,
    foreign_key: :user_id,
    association_foreign_key: :friend_user_id

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? Bcrypt::Engine::MIN_COST : BCrypt::Engine.cost 
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token 
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def set_initial_balance
    self.balance = 10000
  end 

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def is_online
    self.update_attributes(online:true)
  end

  def is_offline
    self.update_attributes(online:false)
  end
end
