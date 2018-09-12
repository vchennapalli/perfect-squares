defmodule App do
  @moduledoc """
    The point of entry for the code
  """
  @doc """
    assigns values to N and k and calls the take control function
    in the Boss module. 
  """
  def main() do
    [n, k] = System.argv()
    n = String.to_integer(n)
    k = String.to_integer(k)
    
    if k > 0 && n >= 0 do
      batch_size = decide_batch_size(n)
      Boss.take_control(n, k, batch_size)
    end
  end

  @doc """
    calculates the number of actors needed for the problem
    based on the value of n
  """
  def decide_batch_size(n) do
    cond do
      n > 10000 -> div(n, 10000)
      true -> 1
    end
  end
end


defmodule Boss do
  @moduledoc """
    This module spawns the worker actors and handles 
    those messages
    """
    def take_control(n, k, size) do
      boss_id = self()
      num_workers = Kernel.trunc(Float.ceil(n / size)) 
      spawn_workers(n, k, size, boss_id)
      listen(num_workers)
      Process.sleep 1000
    end


    @doc """
      spawns the worker actors
    """
    def spawn_workers(n, k, size, boss_id) do
      if n - size < 0 do
        spawn_workers(n, k, boss_id)
      else
        spawn(Worker, :check, [n - size + 1, n, k, boss_id])
        spawn_workers(n - size, k, size, boss_id)
      end
    end

    @doc """
      spawns the last set of worker actors whne n < size
    """
    def spawn_workers(n, k, boss_id) do
      spawn(Worker, :check, [1, n, k, boss_id])
    end

    @doc """
      listens to the messages from the worker actors
    """
    def listen(num_workers\\0) do
      receive do
        {:exit} -> 
          num_workers = num_workers - 1
          if num_workers > 0 do
            listen(num_workers) 
          end
      end 
    end
end


defmodule Worker do
  @moduledoc """
    This module takes care of the workers
    """
    @doc """
      Recursive function that checks if any of the 
      sequences starting with a number between start
      and finish of size k has perfect squares.
    """
    def check(start, finish, k, boss_id) do
      if start <= finish do
        #last number of the k sized sequence
        last = start + k - 1
        sum = get_sum_of_squares(start, last)

        if has_perfect_sqrt(sum) do
          IO.puts start
        end
        check(start+1, finish, k, boss_id)
      else
        send boss_id, {:exit}
      end
    end

    @doc """
      gets sum of squares of nums from start (included) to last
    """
    def get_sum_of_squares(start, finish) do
      get_sum_of_squares(finish) - get_sum_of_squares(start-1)
    end

    @doc """
      gets the sum of squares from 1 to n
    """
    def get_sum_of_squares(n) do
      div(n * (n+1) * (2*n+1), 6)
    end

    @doc """
      checks if num has perfect square root
    """
    def has_perfect_sqrt(num) do
      sqrt = :math.sqrt(num)
      sqrt == Kernel.trunc(sqrt)
    end
end

App.main()