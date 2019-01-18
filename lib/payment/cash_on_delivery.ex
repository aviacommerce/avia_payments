defmodule SnitchPayments.Payment.CashOnDelivery do
  @moduledoc """
  Module to expose utilities and functions for the payemnt
  type `cash on delivery`.
  """
  alias SnitchPayments.PaymentMethodCode

  @preferences [:cod_fee]

  @doc """
  Returns a list of preferences for this payment type.

  At present returns only the "fee" to be charged for `cod`.
  """
  @spec preferences() :: list
  def preferences do
    @preferences
  end

  @doc """
  Returns the `payment code` for the gateway.

  The given module implements functionality for
  payubiz as `hosted payment`. The code is returned
  for the same.
  > See
   `SnitchPayments.PaymentMethodCodes`
  """
  @spec payment_code() :: String.t()
  def payment_code do
    PaymentMethodCode.cash_on_delivery()
  end
end
