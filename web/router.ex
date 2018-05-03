defmodule App.Router do
  use App.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", App do
    pipe_through :browser # Use the default browser stack

    get "/", ChatController, :index

    post "/auth", AuthController, :authenticate

    get "/:roomId", ChatController, :chat
  end

  scope "/api", App do
    pipe_through :api

    post "/sendMessage", ApiController, :sendMessage
  end
end
