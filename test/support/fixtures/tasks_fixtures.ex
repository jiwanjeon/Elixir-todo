defmodule Todo.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todo.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        text: "some text"
      })
      |> Todo.Tasks.create_task()

    task
  end

  def tasks_fixture(attrs \\ %{}) do
    {:ok, task1} =
      attrs
      |> Enum.into(%{
        completed: false,
        test: "some text"
      })
      |> Todo.Tasks.create_task()

      {:ok, task2} =
        attrs
        |> Enum.into(%{
          completed: false,
          test: "some text"
        })
        |> Todo.Tasks.create_task()

        {:ok, task3} =
          attrs
          |> Enum.into(%{
            completed: true,
            test: "some text"
          })
          |> Todo.Tasks.create_task()

    [task2, task1, task3]
  end
end
