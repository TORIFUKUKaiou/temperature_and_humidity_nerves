defmodule TemperatureAndHumidityNerves.Aht20 do
  use Bitwise
  alias Circuits.I2C

  @i2c_bus "i2c-1"
  @i2c_addr 0x38
  @initialization_command <<0xBE, 0x08, 0x00>>
  @trigger_measurement_command <<0xAC, 0x33, 0x00>>
  @two_pow_20 :math.pow(2, 20)

  def read do
    {:ok, ref} = I2C.open(@i2c_bus)

    I2C.write(ref, @i2c_addr, @initialization_command)
    Process.sleep(10)

    I2C.write(ref, @i2c_addr, @trigger_measurement_command)
    Process.sleep(80)

    ret =
      case I2C.read(ref, @i2c_addr, 7) do
        {:ok, val} -> {:ok, val |> convert()}
        {:error, :i2c_nak} -> {:error, "Sensor is not connected"}
        _ -> {:error, "An error occurred"}
      end

    I2C.close(ref)

    ret
  end

  defp convert(<<_, h1, h2, ht3, t4, t5, _>>) do
    raw_humi = h1 <<< 12 ||| h2 <<< 4 ||| ht3 >>> 4
    humi = Float.round(raw_humi / @two_pow_20 * 100.0, 1)

    raw_temp = (ht3 &&& 0x0F) <<< 16 ||| t4 <<< 8 ||| t5
    temp = Float.round(raw_temp / @two_pow_20 * 200.0 - 50.0, 1)

    {temp, humi}
  end
end
