defmodule Infrastructure.OpenAi.Request.Body do
  @derive Jason.Encoder
  defstruct [:model, :messages, :temperature]

  defmodule Message do
    @derive Jason.Encoder
    defstruct [:role, :content]

    def new(attrs \\ []) do
      attrs = Keyword.validate!(attrs, [:role, :content])
      struct!(__MODULE__, attrs)
    end
  end

  def new(attrs \\ []) do
    attrs = Keyword.validate!(attrs, [:model, :messages, :temperature])
    struct!(__MODULE__, attrs)
  end
end
