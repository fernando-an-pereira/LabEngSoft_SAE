class CreateExames < ActiveRecord::Migration
  def change
    create_table :exames do |t|
      t.string :nomeDoLaboratorio
      t.string :tipo
      t.string :resultado
      t.datetime :data

      t.timestamps
    end
  end
end
