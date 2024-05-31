defmodule OutputTracking do
  def track_output(handler_id, event_name) do
    :telemetry.attach(handler_id, event_name, OutputTracking.handle_event(self()), nil)
  end

  def handle_event(self) do
    fn event_name, _measurements, metadata, _config ->
      [module, function | _] = event_name
      send(self, {[module, function], metadata})
    end
  end

  def emit(event_name, data) do
    :telemetry.execute(event_name, %{}, data)
  end
end
