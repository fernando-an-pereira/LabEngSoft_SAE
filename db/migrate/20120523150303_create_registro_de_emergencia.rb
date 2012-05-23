class CreateRegistroDeEmergencia < ActiveRecord::Migration
  def change
    create_table :registro_de_emergencia do |t|
      t.datetime :data
      t.text :localidadeEmergencia
      t.text :gravidade
      t.text :causas

      t.timestamps
    end
  end
end