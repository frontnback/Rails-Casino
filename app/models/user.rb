class User < ApplicationRecord
  before_create { email.downcase! }
  before_create :confirmation_token
  before_create :set_initial_balance
  validates :username, presence: true, length: { maximum: 15 }, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, on: :create
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_many :messages
  has_and_belongs_to_many :friendships,
    class_name: 'User',
    join_table: :friendships,
    foreign_key: :user_id,
    association_foreign_key: :friend_user_id

  def User.digest(string)
    cost = ActiveRecord::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def set_initial_balance
    self.balance = 10000
  end 

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  private

    def confirmation_token 
      if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end
