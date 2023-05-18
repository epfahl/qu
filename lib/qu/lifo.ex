defmodule Qu.LIFO do
  alias __MODULE__, as: Q

  @type max_size :: pos_integer() | :infinity

  @type t :: %Q{
          stack: list(),
          size: integer(),
          max_size: max_size()
        }

  defstruct stack: [], size: 0, max_size: :infinity

  @spec new(max_size()) :: Q.t()
  def new(max_size \\ :infinity) do
    %Q{} |> Map.put(:max_size, max_size)
  end

  @spec push(Q.t(), any) :: {:ok, Q.t()} | :error
  def push(%Q{size: size, max_size: max_size}, _) when size == max_size do
    :error
  end

  def push(%Q{stack: stack, size: size} = q, item) do
    {:ok, %{q | stack: [item | stack], size: size + 1}}
  end

  @spec pop(Q.t()) :: {:ok, any(), Q.t()} | :error
  def pop(%Q{stack: []}), do: :error

  def pop(%Q{stack: [item | rest], size: size} = q) do
    {:ok, item, %{q | stack: rest, size: size - 1}}
  end

  @spec size(Q.t()) :: integer()
  def size(%Q{size: size}), do: size
end
