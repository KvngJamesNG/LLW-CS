class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :company_number
      t.date :incorporated_on
      t.string :status
      t.text :address

      t.timestamps
    end
  end
end
