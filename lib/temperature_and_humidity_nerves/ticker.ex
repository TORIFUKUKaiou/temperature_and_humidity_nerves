defmodule TemperatureAndHumidityNerves.Ticker do
  use GenServer
  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    :timer.send_interval(1000, self(), :tick)
    {:ok, state}
  end

  def handle_info(:tick, state) do
    Logger.debug("tick")
    spawn(TemperatureAndHumidityNerves.Worker, :run, [])

    {:noreply, state}
  end
end
