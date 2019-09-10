defmodule BeSpiral.Repo do
  @moduledoc """
  Implementation for our Repo in BeSpiral
  """
  use Ecto.Repo,
    otp_app: :bespiral,
    adapter: Ecto.Adapters.Postgres

  alias Postgrex.Notifications

  @doc """
  Listener for an event on on the PostgreSQL Channels this function accepts an event name to listen to
  and will connect to our database and listen for an event of the provided name occuring
  """
  @spec listen(String.t()) :: {:ok, pid(), reference()}
  def listen(name) do
    with {:ok, pid} <- Notifications.start_link(__MODULE__.config()),
         {:ok, ref} <- Notifications.listen(pid, name) do
      {:ok, pid, ref}
    end
  end
end
