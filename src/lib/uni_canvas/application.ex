defmodule UniCanvas.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UniCanvasWeb.Telemetry,
      # Start the Ecto repository
      UniCanvas.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: UniCanvas.PubSub},
      # Start Finch
      {Finch, name: UniCanvas.Finch},
      # Start the Endpoint (http/https)
      UniCanvasWeb.Endpoint
      # Start a worker by calling: UniCanvas.Worker.start_link(arg)
      # {UniCanvas.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UniCanvas.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UniCanvasWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
