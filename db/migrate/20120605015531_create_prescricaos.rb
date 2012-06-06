class CreatePrescricaos < ActiveRecord::Migration
  def change
    create_table :prescricaos do |t|
      t.string :nomeMedicamento
      t.string :dosagem
      t.string :frequencia
      t.references :prontuario

      t.timestamps
    end
  end
end
