defmodule App.ApiController do
	use App.Web, :controller

	alias App.ChatView

	alias App.Message

	def sendMessage(conn, params) do
		changeset = Message.changeset(%Message{}, params)

		case Repo.insert(changeset) do
			{:ok, message} ->
				IO.inspect message

				newMessage = %{message | inserted_at: ChatView.dateTimeFormat(message.inserted_at)}

				json(conn, newMessage)
			{:error, _error}
				-> conn |> put_status(:bad_request) |> json(%{})
		end
	end
end
