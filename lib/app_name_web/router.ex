defmodule AppNameWeb.Router do
  use AppNameWeb, :router

  pipeline :api do
    # plug(RemoteIp)
    plug(Plug.RequestId, assign_as: :plug_request_id)
    plug(JSONAPI.EnsureSpec)
    plug(JSONAPI.Deserializer)
    plug(JSONAPI.UnderscoreParameters)
    plug(:accepts, ["json-api"])
    plug(AppName.VerifyAdminRequest)
  end

  scope "/api", AppNameWeb do
    pipe_through :api

    get "/login", PageController, :home
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:app_name, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AppNameWeb.Telemetry
    end
  end
end
