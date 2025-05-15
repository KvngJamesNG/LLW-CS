class CreateApplicants < ActiveRecord::Migration[7.1]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :message
      t.binary :cv
      t.binary :other_documents

      t.timestamps
    end
  end
end
