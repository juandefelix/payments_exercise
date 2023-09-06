class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.date :date, index: true, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.references :loan

      t.timestamps
    end
  end
end
