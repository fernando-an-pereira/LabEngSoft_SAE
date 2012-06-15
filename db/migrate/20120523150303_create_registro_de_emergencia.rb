class CreateRegistroDeEmergencia < ActiveRecord::Migration
  def change
    create_table :registro_de_emergencia do |t|
      t.datetime :data
      t.text :localidadeEmergencia
      t.text :gravidade
      t.text :causas
      t.boolean :consulta_virtual
      t.boolean :redireciona_veiculo
      t.references :prontuario
      t.references :atendente
      t.references :medico
      t.references :veiculo_de_saude

      t.timestamps
    end
  end
end
