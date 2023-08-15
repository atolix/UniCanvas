defmodule UniCanvas.Repo do
  use Ecto.Repo,
    otp_app: :uni_canvas,
    adapter: Ecto.Adapters.Postgres
end
