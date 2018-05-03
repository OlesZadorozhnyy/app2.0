defmodule App.RoomChannel do
	use Phoenix.Channel

	alias Poison
	use App.ChatApi

	def join("room", _payload, socket) do
		{:ok, socket}
	end

	def handle_in("message:new", params, socket) do
		{:ok, encodedParams} = Poison.encode(params)
		case App.ChatApi.sendMessage(encodedParams) do
			{:ok, response} ->
				if response.status_code == 200 do
					{:ok, decodedBody} = Poison.decode(response.body)

					broadcast!(socket, "message:new", decodedBody)
				end
				{:noreply, socket}
			_ ->
				{:noreply, socket}
		end
	end
end