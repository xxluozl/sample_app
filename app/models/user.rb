class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  default_scope -> { order(created_at: :asc) }
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy #主动关系，我主动关注别人
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy #被动关系，我被别人关注
  has_many :following, through: :active_relationships, source: :followed #following方法返回关注者数组，并且可以向数组一样增加和删除元素
  has_many :followers, through: :passive_relationships, source: :follower #followed方法返回粉丝数组，并且可以向数组一样增加和删除元素
  before_create :create_activation_digest
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  validates :signature, length: { maximum: 48 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, #{ case_sensitive: false }, #唯一且不区分大小写
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

  def authenticate?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # 返回一个会话令牌，防止会话劫持
  # 简单起见，直接使用记忆令牌
  def session_token
    remember_digest || remember
  end

  def activate_account
    self.update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    self.update_columns(reset_digest: User.digest(reset_token), reset_send_at: Time.zone.now)
  end

  def reset_token_expired?
    self.reset_send_at < 2.hours.ago
  end

  #实现动态流原型
  def feed
    Micropost.where(user_id: id)
  end

  #关注用户的相关方法
  def follow(other_user)
    following << other_user unless self == other_user
    # active_relationships.create(followed_id: other_user.id) #这种写法会同时查询当前user和关注的user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def follow?(other_user)
    following.include?(other_user)
  end

  private

  def downcase_email
    #存入数据库前转为小写,使用爆炸方法实现回调，也可以用 self.email = email.downcase 实现回调
    email.downcase!
  end

  # 创建激活令牌和摘要
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
