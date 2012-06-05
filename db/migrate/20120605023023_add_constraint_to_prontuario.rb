class AddConstraintToProntuario < ActiveRecord::Migration
  def up
	add_column :prontuarios, :paciente_id, :integer
		
	execute <<-SQL
		ALTER TABLE prontuarios
			ADD CONSTRAINT fk_prontuarios_pacientes
			FOREIGN KEY (paciente_id)
			REFERENCES pessoas(id)
	SQL
  end
end
