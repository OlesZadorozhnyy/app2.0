defmodule App.ChatController do
	use App.Web, :controller

	alias App.Message

	def index(conn, _params) do
		username = get_session(conn, :username)

		rooms = if username, do: Repo.all(from s in App.Room), else: []

		conn
		|> assign(:authorized, username)
		|> assign(:rooms, rooms)
		|> render("index.html")
	end

	def chat(conn, %{"roomId" => roomId}) do
		username = get_session(conn, :username)

		if isValidRoom(roomId) && username do
			messages = Repo.all(from s in Message, where: s.roomId == ^roomId)

			conn
			|> assign(:messages, messages)
			|> assign(:username, username)
			|> assign(:roomId, roomId)
			|> render("chat.html")
		else
			path = chat_path(conn, :index)
			conn |> redirect(to: path)
		end
	end

	defp isValidRoom(roomId) do
		case Integer.parse(roomId) do
			{_, ""} -> true
			_ -> false
		end
	end
end
