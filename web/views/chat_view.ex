defmodule App.ChatView do
	use App.Web, :view

	def dateTimeFormat(datetime) do
		numberFormat = fn item -> item |> Integer.to_string() |> String.pad_leading(2, "0") end

		date = "#{datetime.year}-#{numberFormat.(datetime.month)}-#{numberFormat.(datetime.day)}"
		time = "#{numberFormat.(datetime.hour)}:#{numberFormat.(datetime.minute)}:#{numberFormat.(datetime.second)}"

		date <> " " <> time
	end
end
