defmodule UniCanvas.Repo.Migrations.CreateCells do
  use Ecto.Migration

  def change do
    create table(:cells) do
      add :row, :integer
      add :col, :integer
      add :color, :string

      timestamps()
    end
  end
end
