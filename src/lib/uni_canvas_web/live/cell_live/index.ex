defmodule UniCanvasWeb.CellLive.Index do
  use UniCanvasWeb, :live_view

  alias UniCanvas.Grid
  alias UniCanvas.Grid.Cell

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cells, Grid.list_cells())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cell")
    |> assign(:cell, Grid.get_cell!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cell")
    |> assign(:cell, %Cell{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cells")
    |> assign(:cell, nil)
  end

  @impl true
  def handle_info({UniCanvasWeb.CellLive.FormComponent, {:saved, cell}}, socket) do
    {:noreply, stream_insert(socket, :cells, cell)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cell = Grid.get_cell!(id)
    {:ok, _} = Grid.delete_cell(cell)

    {:noreply, stream_delete(socket, :cells, cell)}
  end
end
