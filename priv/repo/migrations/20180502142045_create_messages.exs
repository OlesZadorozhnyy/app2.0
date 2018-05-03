defmodule App.Repo.Migrations.CreateMessages do
	use Ecto.Migration

	def change do
		create table(:messages) do
			add :roomId, :integer
			add :message, :text
			add :user, :text

			timestamps()
		end
	end
end
