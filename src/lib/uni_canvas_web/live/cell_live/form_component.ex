defmodule UniCanvasWeb.CellLive.FormComponent do
  use UniCanvasWeb, :live_component

  alias UniCanvas.Grid

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage cell records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="cell-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:row]} type="number" label="Row" />
        <.input field={@form[:col]} type="number" label="Col" />
        <.input field={@form[:color]} type="text" label="Color" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cell</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cell: cell} = assigns, socket) do
    changeset = Grid.change_cell(cell)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"cell" => cell_params}, socket) do
    changeset =
      socket.assigns.cell
      |> Grid.change_cell(cell_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"cell" => cell_params}, socket) do
    save_cell(socket, socket.assigns.action, cell_params)
  end

  defp save_cell(socket, :edit, cell_params) do
    case Grid.update_cell(socket.assigns.cell, cell_params) do
      {:ok, cell} ->
        notify_parent({:saved, cell})

        {:noreply,
         socket
         |> put_flash(:info, "Cell updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_cell(socket, :new, cell_params) do
    case Grid.create_cell(cell_params) do
      {:ok, cell} ->
        notify_parent({:saved, cell})

        {:noreply,
         socket
         |> put_flash(:info, "Cell created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
