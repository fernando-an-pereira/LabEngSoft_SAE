class CreateProntuarios < ActiveRecord::Migration
  def change
    create_table :prontuarios do |t|
      t.text :observacao
      t.date :data
      t.references :paciente

      t.timestamps
    end
  end
end
