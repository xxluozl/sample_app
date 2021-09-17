class AddIndexToUsersEmail < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true  #建立索引后查询不会全表扫描，提高查询效率，同时解决唯一性问题，但是也有缺点：
                                            # 一是增加了数据库的存储空间，二是在插入和修改数据时要花费较多的时间(因为索引也要随之变动)。
  end
end
