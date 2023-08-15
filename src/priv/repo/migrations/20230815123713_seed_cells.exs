defmodule UniCanvas.Repo.Migrations.SeedCells do
  use Ecto.Migration
  import UniCanvas.Cell

  def up do
    Enum.each(0..255, fn row ->
      Enum.each(0..255, fn col ->
        UniCanvas.Cell.create(%{row: row, col: col, color: "#ffffff"})
      end)
    end)
  end
end
