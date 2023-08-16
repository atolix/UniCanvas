defmodule UniCanvasWeb.GridLive do
  use UniCanvasWeb, :live_view
  import Ecto.Query
 
  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: UniCanvas.Cell.subscribe()

    query = from(c in UniCanvas.Cell, order_by: [asc: c.id])
    {:ok, assign(socket, cells: UniCanvas.Repo.all(query))}
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
          phx-value-id="<%= cell.id %>"
        ></div>
      <% end %>
    </div>
    """
  end

  @impl true
  def handle_event("change_color", %{"id" => id}, socket) do
    target_id = String.to_integer(id)
    updated_color = "#000000"
    target_cell = UniCanvas.Repo.get(UniCanvas.Cell, target_id)

    case UniCanvas.Cell.update(target_cell, %{color: updated_color}) do
      {:ok, updated_cell} ->
        query = from(c in UniCanvas.Cell, order_by: [asc: c.id])
        {:noreply, assign(socket, cells: UniCanvas.Repo.all(query))}
      {:error, changeset} ->
        IO.inspect(changeset.errors)
        {:noreply, socket}
    end
  end

  def handle_info({:updated_cell, cell}, socket) do
    query = from(c in UniCanvas.Cell, order_by: [asc: c.id])
    {:noreply, assign(socket, cells: UniCanvas.Repo.all(query))}
  end
end
