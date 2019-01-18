defmodule SnitchPayments.Gateway.RazorPay do
  @moduledoc """
  Module to expose utilities and functions for the payment
  gateway `razor pay`.
  """

  alias SnitchPayments.PaymentMethodCode
  alias SnitchPayments.Response.HostedPayment

  @behaviour SnitchPayments.Gateway

  @credentials [:key_id, :key_secret]
  @test_url "api.razorpay.com/v1/payments/"
  @live_url "api.razorpay.com/v1/payments/"
  @failure_status "failure"
  @success_status "success"

  @doc """
  Returns the preferences for the gateway, at present it is mainly the
  list of credentials.

  These `credentials` refer to one provided by a `razorpay` to a seller on
  account creation.
  """
  @spec preferences() :: list
  def preferences do
    @credentials
  end

  @doc """
  Returns the `payment code` for the gateway.

  The given module implements functionality for
  razorpay as `hosted payment`. The code is returned
  for the same.
  > See
   `SnitchPayments.PaymentMethodCodes`
  """
  @spec payment_code() :: String.t()
  def payment_code do
    PaymentMethodCode.hosted_payment()
  end

  @doc """
  Returns the `test` and `live` `urls` for razorpay
  hosted payment.
  """
  @spec get_url() :: map
  def get_url do
    %{
      test_url: @test_url,
      live_url: @live_url
    }
  end

  @doc """
  Captures the payment for the supplied params.

  Razor pay needs the payment_id, along with the amount to
  capture the payment.

  The params map requires the following fields to be present
  - `:amount` -> Money.t()
  - `:payment_id` -> String.t()
  """
  def purchase(params, key_id, key_secret) do
    payment_id = params.payment_id
    amount =
      params.amount
      |> Money.mult!(100)
      |> Money.to_decimal()
      |> Decimal.round()

    url = "https://" <> "#{key_id}:#{key_secret}@" <> @test_url <> "#{payment_id}/capture"
    body = {:form, [amount: Decimal.to_string(amount)]}

    commit(url, body, payment_id)
  end

  @doc """
  Parses the `params` supplied and returns a
  `HostedPayment.t()` struct as response.
  """
  @spec parse_response(map) :: HostedPayment.t()
  def parse_response(%{"error" => _errors} = params) do
    params = error_response_mapping(params)
    Map.merge(%HostedPayment{}, params)
  end

  def parse_response(params) do
    params = success_response_mapping(params)
    Map.merge(%HostedPayment{}, params)
  end

  defp commit(url, body, transaction_id) do
    url
    |> HTTPoison.post(body)
    |> respond(transaction_id)
  end

  defp respond({:ok, %{status_code: 200, body: body}}, _) do
    body = Poison.decode!(body)
    {:ok, body}
  end

  defp respond({:ok, %{status_code: 401, body: body}}, transaction_id) do
    body = body |> Poison.decode!() |> Map.put("id", transaction_id)
    {:error, body}
  end

  defp respond({:ok, %{status_code: 400, body: body}}, transaction_id) do
    body = body |> Poison.decode!() |> Map.put("id", transaction_id)
    {:error, body}
  end

  defp success_response_mapping(params) do
    %{
      transaction_id: params["id"],
      payment_source: params["payment_source"],
      raw_response: params,
      status: @success_status,
      order_id: String.to_integer(params["order_id"]),
      payment_id: String.to_integer(params["payment_id"])
    }
  end

  defp error_response_mapping(params) do
    %{
      transaction_id: params["id"],
      payment_source: params["payment_source"],
      raw_response: params,
      status: @failure_status,
      order_id: String.to_integer(params["order_id"]),
      payment_id: String.to_integer(params["payment_id"]),
      error_reason: params["error"]["description"]
    }
  end
end
