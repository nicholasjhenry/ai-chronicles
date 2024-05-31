defmodule Infrastructure.OpenAi.Response.Body do
  defstruct [:choices, :created, :id, :model, :object, :system_fingerprint, :usage]
end
