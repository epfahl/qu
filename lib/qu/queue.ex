defprotocol Qu.Queue do
  alias Qu.Queue, as: Q

  @spec push(Q.t(), any) :: {:ok, Q.t()} | :error
  def push(queue, item)

  @spec pop(Q.t()) :: {:ok, any, Q.t()} | :error
  def pop(queue)

  @spec size(Q.t()) :: integer
  def size(queue)
end

defimpl Qu.Queue, for: Qu.LIFO do
  def push(queue, item), do: Qu.LIFO.push(queue, item)
  def pop(queue), do: Qu.LIFO.pop(queue)
  def size(queue), do: Qu.LIFO.size(queue)
end

defimpl Qu.Queue, for: Qu.FIFO do
  def push(queue, item), do: Qu.FIFO.push(queue, item)
  def pop(queue), do: Qu.FIFO.pop(queue)
  def size(queue), do: Qu.FIFO.size(queue)
end
