defmodule Consumers.Example do
  use Broadway

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {Broadway.DummyProducer, []}
      ],
      processors: [
        default: []
      ]
    )
  end

  @impl true
  def handle_message(_processor, message, _context) do
    Broadway.Message.update_data(message, fn data ->
      open_ai = Infrastructure.OpenAi.Client.create()
      {:ok, response} = Infrastructure.OpenAi.Client.prompt(open_ai, data)

      List.first(response.body["choices"])["message"]["content"]
    end)
  end
end
