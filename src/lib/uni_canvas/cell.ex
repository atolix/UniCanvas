defmodule UniCanvas.Cell do
  use Ecto.Schema
  import Ecto.Changeset

  @topic inspect(__MODULE__)

  schema "cells" do
    field :row, :integer
    field :col, :integer
    field :color, :string

    timestamps()
  end

  def subscribe do
    Phoenix.PubSub.subscribe(UniCanvas.PubSub, @topic)
  end

  def broadcast({:ok, record}, event) do
    Phoenix.PubSub.broadcast(UniCanvas.PubSub, @topic, {event, record})
  end

  def broadcast({:error, _} = error, _event), do: :error

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
    |> case do
      {:ok, updated_cell} ->
        broadcast({:ok, updated_cell}, :updated_cell)
        {:ok, updated_cell}
      {:error, changeset} ->
        broadcast({:error, changeset}, :error)
        {:error, changeset}
    end
  end
end
