defmodule App.Message do
	use Ecto.Schema
	import Ecto.Changeset

	@derive {Poison.Encoder, except: [:__meta__]}

	schema "messages" do
		field :roomId, :integer
		field :message, :string
		field :user, :string

		timestamps()
	end

	def changeset(struct, params \\ %{}) do
		struct
		|> cast(params, [:roomId, :message, :user])
		|> validate_required([:roomId, :message])
		|> validate_length(:message, max: 500)
		|> validate_number(:roomId, less_than_or_equal_to: 5) # TODO: related to table 'rooms'
	end
end