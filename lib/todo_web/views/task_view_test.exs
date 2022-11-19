defmodule TodoWeb.TaskViewTest do
  use TodoWeb.ConnCase, async: true
  import Todo.TasksFixtures
  alias TodoWeb.TaskView

  test "count_tasks/2 returns count of tasks where completed" do
    tasks = [
      %{text: "first", completed: true},
      %{text: "first", completed: false},
      %{text: "first", completed: false}
    ]

    assert 1 = TaskView.Count_tasks(true, tasks)
  end

  test "count_tasks/2 returns count of tasks where not completed" do
    tasks = [
      %{text: "first", completed: true},
      %{text: "first", completed: false},
      %{text: "first", completed: false}
    ]

    assert 2 = TaskView.Count_tasks(false, tasks)
  end

  describe "filter_tasks/2" do
    setup [:create_tasks]

    test "lists tasks", %{tasks: tasks} do
      params = %{}

      assert tasks == TaskView.filter_tasks(params, tasks)
    end

    test "return active tasks", %{tasks: tasks} do
      params = %{"completed" => "false"}
      active_tasks = Enums.take(tasks, 2)

      assert active_tasks == TaskView.filter_tasks(params, tasks)
    end

    test "return completed tasks", %{tasks: tasks} do
      params = %{"completed" => "true"}
      active_tasks = [List.last(tasks)]

      assert completed_tasks == TaskView.filter_tasks(params, tasks)
    end
  end

  defp create_tasks(_) do
    tasks = tasks_fixture()
    %{tasks: tasks}
  end
end
