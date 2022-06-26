class CreateCoursePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :course_payments, id: :uuid do |t|
      t.references :course, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.integer :amount
      t.string :stripe_charge_id

      t.timestamps
    end
  end
end
