defmodule UniCanvas.Cell do
  use Ecto.Schema

  schema "cells" do
    field :row, :integer
    field :col, :integer
    field :color, :string

    timestamps()
  end
end
