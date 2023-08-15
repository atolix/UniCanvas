defmodule UniCanvasWeb.GridLive do
  use UniCanvasWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, cells: UniCanvas.Repo.all(UniCanvas.Cell))}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <div class="grid">
      <%= for cell <- @cells do %>
        <div
          class="cell"
          style="background-color: <%= cell.color %>"
          phx-click="change_color"
          phx-value-row="<%= cell.row %>"
          phx-value-col="<%= cell.col %>"
        ></div>
      <% end %>
    </div>
    """
  end

  @impl true
  def handle_event("change_color", %{"row" => row, "col" => col}, socket) do
    updated_color = "#000000"

    updated_cell = %UniCanvas.Cell{row: String.to_integer(row), col: String.to_integer(col), color: updated_color}
    UniCanvas.Repo.update(updated_cell)

    {:noreply, assign(socket, cells: UniCanvas.Repo.all(UniCanvas.Cell))}
  end
end
