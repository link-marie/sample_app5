class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    # ブロック変数を1つ持つブロック (4.3.2) を受け取ります。
    create_table :users do |t|
      t.string :name
      t.string :email
      # Magic Columnsを作成
      t.timestamps
    end
  end
end
