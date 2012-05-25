class CreateVeiculoDeSaudes < ActiveRecord::Migration
  def change
    create_table :veiculo_de_saudes do |t|
      t.string :RENAVAM
      t.string :latitude
      t.string :longitude
      t.boolean :ocupado

      t.timestamps
    end
  end
end
