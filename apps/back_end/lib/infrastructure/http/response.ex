defmodule Infrastructure.Http.Response do
  defstruct [:status_code, :body, :headers]

  def new(attrs) do
    attrs = Keyword.validate!(attrs, [:status_code, :body, :headers])
    struct!(__MODULE__, attrs)
  end
end
