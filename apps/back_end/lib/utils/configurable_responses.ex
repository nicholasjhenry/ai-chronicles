defmodule ConfigurableResponses do
  use Agent

  def start_link(module, responses \\ []) do
    Agent.start_link(fn -> responses end, name: {:global, {self(), module}})
  end

  def get_response(module, key) do
    agent = {:global, {parent_pid(), module}}

    Agent.get_and_update(agent, fn responses ->
      case Enum.find_index(responses, fn {k, _v} -> k == key end) do
        index when is_integer(index) ->
          {{_key, value}, new_responses} = List.pop_at(responses, index)
          {value, new_responses}

        nil ->
          {nil, responses}
      end
    end)
  end

  defp parent_pid do
    case Process.get(:"$callers") do
      [parent_id | _] -> parent_id
      nil -> self()
    end
  end

  # def increment do
  #   Agent.update(__MODULE__, &(&1 + 1))
  # end
end
