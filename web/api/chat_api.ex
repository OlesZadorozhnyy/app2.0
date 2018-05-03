defmodule App.ChatApi do
	use HTTPoison.Base

	@getMethod "GET"
	@postMethod "POST"

	def __using__(_) do
		nil
	end

	@url "/api/sendMessage"
	def sendMessage(params) do
		send(@url, @postMethod, params)
	end

	defp send(url, "GET", _data) do
		getFullUrl(url) |> HTTPoison.get()
	end

	defp send(url, "POST", data) do
		getFullUrl(url) |> HTTPoison.post(data, [{ "Content-Type", "application/json" }])
	end

	defp getFullUrl(url) do
		App.Endpoint.url <> url
	end
end