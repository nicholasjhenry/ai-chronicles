defmodule Consumers.ExampleTest do
  use ExUnit.Case, async: true
  use Mimic

  setup :set_mimic_global

  test "test message", %{test: test} do
    OutputTracking.track_output(test, [:open_ai_client, :prompt])

    stub(Infrastructure.OpenAi.Client, :create, fn ->
      Infrastructure.OpenAi.Client.create_null(response: "This is a test")
    end)

    ref = Broadway.test_message(Consumers.Example, 1)

    assert_receive {:ack, ^ref, [%{data: "This is a test"}], []}
    assert_receive {[:open_ai_client, :prompt], %{text: 1}}
  end
end
