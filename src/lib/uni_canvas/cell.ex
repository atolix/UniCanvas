defmodule UniCanvas.Cell do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cells" do
    field :row, :integer
    field :col, :integer
    field :color, :string

    timestamps()
  end

  def create(attrs) do
    UniCanvas.Repo.insert(%UniCanvas.Cell{row: attrs[:row], col: attrs[:col], color: attrs[:color]})
  end
end
