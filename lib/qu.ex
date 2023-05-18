defmodule Qu do
  alias Qu.Queue, as: Q

  @doc """
  Create a new queue.

  The `queue_type` may be `:fifo` or `:lifo`, and the maximum length of the
  queue may be a positive integer or `:infinity`.
  """
  @spec new(atom, pos_integer() | :infinity) :: Queue.t()
  def new(queue_type, max_size \\ :infinity)

  def new(queue_type, max_size) do
    case queue_type do
      :fifo ->
        Qu.FIFO.new(max_size)

      :lifo ->
        Qu.LIFO.new(max_size)

      _ ->
        raise ArgumentError,
          message: "queue type `#{inspect(queue_type)}` not recognized"
    end
  end

  @doc """
  Push an item onto a queue.

  If the queue size is less than the maximum size, this returns
  `{:ok, updated_queue}`. If the queue size equals the maximum, `:error` is
  returned.
  """
  @spec push(Q.t(), any) :: {:ok, Q.t()} | :error
  def push(queue, item), do: Q.push(queue, item)

  @doc """
  Pop an item from a queue.

  If there is at least one item in the queue, this returns
  `{:ok, item, updated_queue}`. If the queue is empty, `:error` is returned.
  """
  @spec pop(Q.t()) :: {:ok, Q.t()} | :error
  def pop(queue), do: Q.pop(queue)

  @doc """
  The size of the queue.
  """
  @spec size(Q.t()) :: non_neg_integer()
  def size(queue), do: Q.size(queue)
end
