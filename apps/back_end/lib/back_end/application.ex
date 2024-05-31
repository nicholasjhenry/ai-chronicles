defmodule BackEnd.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Consumers.Example
    ]

    opts = [strategy: :one_for_one, name: BackEnd.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
