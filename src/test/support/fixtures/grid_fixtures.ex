defmodule UniCanvas.GridFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UniCanvas.Grid` context.
  """

  @doc """
  Generate a cell.
  """
  def cell_fixture(attrs \\ %{}) do
    {:ok, cell} =
      attrs
      |> Enum.into(%{
        color: "some color",
        row: 42,
        col: 42
      })
      |> UniCanvas.Grid.create_cell()

    cell
  end
end
