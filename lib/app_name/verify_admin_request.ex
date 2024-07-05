defmodule AppName.VerifyAdminRequest do
  require Logger

  defmodule UnauthorizedRequestError do
    @moduledoc """
    Error raised when the Admin request is not authorized.
    """

    defexception message: "Admin request unauthorized", plug_status: 403
  end

  def init(options), do: options

  def call(%{path_info: ["api/login" | _rest]} = conn, _opts) do
    verify_request!()
    conn
  end

  defp verify_request!() do
    raise(UnauthorizedRequestError)
  end
end
