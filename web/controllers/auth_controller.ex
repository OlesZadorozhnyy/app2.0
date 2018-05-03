defmodule App.AuthController do
	use App.Web, :controller

	def authenticate(conn, %{"username" => username} = params) when byte_size(username) > 0 do
		cond do
			username |> String.trim() |> String.length() == 0 -> authenticate(conn, params)
			true -> 
				path = auth_path(conn, :authenticate)
				conn |> put_session(:username, username) |> redirect(to: path)
		end
	end

	def authenticate(conn, _params) do
		path = auth_path(conn, :authenticate)
		conn |> put_flash(:error, "Fail authentication") |> redirect(to: path)
	end
end
