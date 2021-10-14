class AddSignatureToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :signature, :string, default: '暂无简介'
  end
end
