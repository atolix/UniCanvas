defmodule UniCanvas.Grid.Cell do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cells" do
    field :color, :string
    field :row, :integer
    field :col, :integer

    timestamps()
  end

  @doc false
  def changeset(cell, attrs) do
    cell
    |> cast(attrs, [:row, :col, :color])
    |> validate_required([:row, :col, :color])
  end
end
