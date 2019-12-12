class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.string :name
      t.belongs_to :hospital, index: true, type: :integer
    end
  end
end
