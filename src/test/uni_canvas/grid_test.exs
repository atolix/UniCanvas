defmodule UniCanvas.GridTest do
  use UniCanvas.DataCase

  alias UniCanvas.Grid

  describe "cells" do
    alias UniCanvas.Grid.Cell

    import UniCanvas.GridFixtures

    @invalid_attrs %{color: nil, row: nil, col: nil}

    test "list_cells/0 returns all cells" do
      cell = cell_fixture()
      assert Grid.list_cells() == [cell]
    end

    test "get_cell!/1 returns the cell with given id" do
      cell = cell_fixture()
      assert Grid.get_cell!(cell.id) == cell
    end

    test "create_cell/1 with valid data creates a cell" do
      valid_attrs = %{color: "some color", row: 42, col: 42}

      assert {:ok, %Cell{} = cell} = Grid.create_cell(valid_attrs)
      assert cell.color == "some color"
      assert cell.row == 42
      assert cell.col == 42
    end

    test "create_cell/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Grid.create_cell(@invalid_attrs)
    end

    test "update_cell/2 with valid data updates the cell" do
      cell = cell_fixture()
      update_attrs = %{color: "some updated color", row: 43, col: 43}

      assert {:ok, %Cell{} = cell} = Grid.update_cell(cell, update_attrs)
      assert cell.color == "some updated color"
      assert cell.row == 43
      assert cell.col == 43
    end

    test "update_cell/2 with invalid data returns error changeset" do
      cell = cell_fixture()
      assert {:error, %Ecto.Changeset{}} = Grid.update_cell(cell, @invalid_attrs)
      assert cell == Grid.get_cell!(cell.id)
    end

    test "delete_cell/1 deletes the cell" do
      cell = cell_fixture()
      assert {:ok, %Cell{}} = Grid.delete_cell(cell)
      assert_raise Ecto.NoResultsError, fn -> Grid.get_cell!(cell.id) end
    end

    test "change_cell/1 returns a cell changeset" do
      cell = cell_fixture()
      assert %Ecto.Changeset{} = Grid.change_cell(cell)
    end
  end
end
