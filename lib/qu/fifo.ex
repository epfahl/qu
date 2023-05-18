defmodule Qu.FIFO do
  alias __MODULE__, as: Q

  @type max_size :: pos_integer() | :infinity

  @type t :: %Q{
          read: list(),
          write: list(),
          size: integer(),
          max_size: max_size()
        }

  defstruct read: [], write: [], size: 0, max_size: :infinity

  @spec new(max_size) :: Q.t()
  def new(max_size \\ :infinity) do
    %Q{} |> Map.put(:max_size, max_size)
  end

  @spec push(Q.t(), any) :: {:ok, Q.t()} | :error
  def push(%Q{size: size, max_size: max_size}, _) when size == max_size do
    :error
  end

  def push(%Q{write: write, size: size} = q, item) do
    {:ok, %{q | write: [item | write], size: size + 1}}
  end

  @spec pop(Q.t()) :: {:ok, any, Q.t()} | :error
  def pop(%Q{read: [], write: []}), do: :error

  def pop(%Q{read: [], write: [_ | _] = write, size: size} = q) do
    [item | read] = Enum.reverse(write)
    {:ok, item, %{q | read: read, write: [], size: size - 1}}
  end

  def pop(%Q{read: [item | read], size: size} = q) do
    {:ok, item, %{q | read: read, size: size - 1}}
  end

  @spec size(Q.t()) :: integer()
  def size(%Q{size: size}), do: size
end
