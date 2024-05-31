defmodule Infrastructure.Http.Request do
  defstruct [:url, :headers, :body]

  def new(attrs) do
    attrs = Keyword.validate!(attrs, [:url, :headers, :body])
    struct!(__MODULE__, attrs)
  end
end
