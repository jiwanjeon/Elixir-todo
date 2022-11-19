defmodule TodoWeb.TaskController do
  use TodoWeb, :controller

  alias Todo.Tasks
  alias Todo.Tasks.Task

  def index(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    conn
    |> assign(:changeset, changeset)
    |> assign(:tasks, Tasks.list_tasks())
    |> render("index.html")
    # tasks = Tasks.list_tasks()
    # render(conn, "index.html", tasks: tasks)
  end

  # def new(conn, _params) do
  #   changeset = Tasks.change_task(%Task{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   task = Tasks.get_task!(id)
  #   render(conn, "show.html", task: task)
  # end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  def clear(conn, _params) do
    Tasks.clear()

    redirect(conn, to: Routes.task_path(conn, :index))
  end

  def complete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    Tasks.update_task(task, completed?(task.completed))
    redirect(conn, to: Routes.task_path(conn, :index))
  end

  defp completed?(false), do: %{"completed" => "true"}
  defp completed?(true), do: %{"completed" => "false"}
end
