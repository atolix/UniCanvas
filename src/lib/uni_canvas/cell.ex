defmodule UniCanvas.Cell do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cells" do
    field :row, :integer
    field :col, :integer
    field :color, :string

    timestamps()
  end

  def changeset(cell, attrs) do
    cell
    |> cast(attrs, [:id, :row, :col, :color])
    |> validate_required([:row, :col, :color])
  end

  def create(attrs) do
    UniCanvas.Repo.insert(%UniCanvas.Cell{row: attrs[:row], col: attrs[:col], color: attrs[:color]})
  end

  def update(%UniCanvas.Cell{} = cell, attrs) do
    cell
    |> changeset(attrs)
    |> UniCanvas.Repo.update()
  end
end
