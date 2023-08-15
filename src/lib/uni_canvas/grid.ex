defmodule UniCanvas.Grid do
  @moduledoc """
  The Grid context.
  """

  import Ecto.Query, warn: false
  alias UniCanvas.Repo

  alias UniCanvas.Grid.Cell

  @doc """
  Returns the list of cells.

  ## Examples

      iex> list_cells()
      [%Cell{}, ...]

  """
  def list_cells do
    Repo.all(Cell)
  end

  @doc """
  Gets a single cell.

  Raises `Ecto.NoResultsError` if the Cell does not exist.

  ## Examples

      iex> get_cell!(123)
      %Cell{}

      iex> get_cell!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cell!(id), do: Repo.get!(Cell, id)

  @doc """
  Creates a cell.

  ## Examples

      iex> create_cell(%{field: value})
      {:ok, %Cell{}}

      iex> create_cell(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cell(attrs \\ %{}) do
    %Cell{}
    |> Cell.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cell.

  ## Examples

      iex> update_cell(cell, %{field: new_value})
      {:ok, %Cell{}}

      iex> update_cell(cell, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cell(%Cell{} = cell, attrs) do
    cell
    |> Cell.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cell.

  ## Examples

      iex> delete_cell(cell)
      {:ok, %Cell{}}

      iex> delete_cell(cell)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cell(%Cell{} = cell) do
    Repo.delete(cell)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cell changes.

  ## Examples

      iex> change_cell(cell)
      %Ecto.Changeset{data: %Cell{}}

  """
  def change_cell(%Cell{} = cell, attrs \\ %{}) do
    Cell.changeset(cell, attrs)
  end
end
