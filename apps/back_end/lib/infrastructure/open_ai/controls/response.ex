defmodule Infrastructure.OpenAi.Controls.Response do
  def example(content) do
    %{
      id: "chatcmpl-9BnH95WAEUof3LwWYCYOcFAeC1rWr",
      object: "chat.completion",
      created: 0,
      model: "gpt-3.5-turbo-0125",
      choices: [
        %{
          index: 0,
          message: %{
            role: "assistant",
            content: content
          },
          logprobs: nil,
          finish_reason: "stop"
        }
      ],
      usage: %{
        prompt_tokens: 13,
        completion_tokens: 5,
        total_tokens: 18
      },
      system_fingerprint: "fp_b28b39ffa8"
    }
  end
end
