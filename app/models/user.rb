class User < ApplicationRecord
  before_save { email.downcase! } #存入数据库前转为小写,使用爆炸方法实现回调，也可以用 self.email = email.downcase 实现回调
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, length: { maximum: 255 }, uniqueness: true, #{ case_sensitive: false }, #唯一且不区分大小写
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  has_secure_password
  # 1：创建password 和 password_confirmation两个虚拟属性，并会执行存在性验证和匹配验证
  # 2：在数据库中的 password_digest 字段存储安全的密码哈希值；所以要先向users表中添加该字段
  # 3：获得 authenticate 方法，如果密码正确，返回对应的用户对象，否则返回 false
end
