class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { email.downcase! } #存入数据库前转为小写,使用爆炸方法实现回调，也可以用 self.email = email.downcase 实现回调
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :email, length: { maximum: 255 }, uniqueness: true, #{ case_sensitive: false }, #唯一且不区分大小写
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_secure_password
  # 1：创建password 和 password_confirmation两个虚拟属性，并会执行存在性验证和匹配验证
  # 2：在数据库中的 password_digest 字段存储安全的密码哈希值；所以要先向users表中添加该字段
  # 3：获得 authenticate 方法，如果密码正确，返回对应的用户对象，否则返回 false

  # 返回指定字符串的哈希摘要
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64 # 返回一个随机令牌
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  def authenticate?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # 返回一个会话令牌，防止会话劫持
  # 简单起见，直接使用记忆令牌
  def session_token
    remember_digest || remember
  end
end
