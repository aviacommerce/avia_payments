defmodule SnitchPayments do
  @moduledoc """
  Documentation for `SnitchPayments`.
  """
  alias SnitchPayments.Provider

  def payment_providers do
    with {:ok, list} = :application.get_key(:snitch_payments, :modules) do
      list
      |> Enum.filter(&payment_provider_filter(&1))
      |> Enum.map(fn gateway ->
        [hd | _] =
          gateway
          |> Atom.to_string()
          |> String.split(".")
          |> Enum.reverse()

        {hd, gateway}
      end)
    end
  end

  @doc """
  Parses the `params` supplied and returns a struct
  depending on the type of payment gateway used for
  transaction.

  Expects a `"source"` key in the params map.
  """
  @spec data_parser(map) :: term
  def data_parser(params) do
    provider = Provider.module(params["payment_source"])
    provider.parse_response(params)
  end

  defp payment_provider_filter(gateway) do
    key_list = gateway |> Module.split()

    key_word =
      Enum.find(key_list, fn key ->
        key == "Gateway" || key == "CashOnDelivery"
      end)

    length(key_list) >= 3 and key_word != nil
  end
end
