defmodule AppName.VerifyAdminRequest do
  import Plug.Conn
  require Logger
  alias AppName.Accounts.User
  alias AppName.Accounts.UserToken

  defmodule UnauthorizedRequestError do
    @moduledoc """
    Error raised when the Admin request is not authorized.
    """

    defexception message: "Admin request unauthorized", plug_status: 403
  end

  def init(options), do: options

  def call(%{path_info: ["log_in" | _rest]} = conn, _opts) do
    conn
  end

  def call(conn, _opts) do
    verify_request!(conn)
    conn
  end

  defp verify_request!(conn) do
    with token <- get_token(conn),
         {:ok, _} <- check_token!(token) do
      true
    else
      _ ->
        raise(UnauthorizedRequestError)
    end
  end

  @spec get_token(Plug.Conn.t()) :: nil | binary
  def get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> token
      _ -> nil
    end
  end

  @spec check_token!(nil | binary) ::
          {:error, :expired | :invalid | :missing} | {:ok, any}
  def check_token!(token) do
    with {:ok, query} <- UserToken.verify_session_token_query(token),
         %User{} = _user <-
           AppName.Repo.one(query) do
      {:ok, "authorized"}
    else
      {:error, error} ->
        Logger.error("Admin Api /check error!")
        {:error, error}

      :error ->
        Logger.error("Admin Api /check error!")
        {:error, "unauthorized"}

      nil ->
        Logger.error("Admin Api /check error!")
        {:error, "unauthorized"}
    end
  end
end
