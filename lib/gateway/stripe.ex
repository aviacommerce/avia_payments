defmodule SnitchPayments.Gateway.Stripe do
  @moduledoc """
  Module to expose utilities and functions for the payemnt
  gateway `stripe`.
  """
  alias SnitchPayments.PaymentMethodCode

  @behaviour SnitchPayments.Gateway
  @credentials [:secret_key]

  @doc """
  Returns the preferences for the gateway, at present it is mainly the
  list of credentials.

  These `credentials` refer to one provided by a `paubiz` to a seller on
  account creation.
  """
  @spec preferences() :: list
  def preferences do
    @credentials
  end

  @doc """
  Returns the `payment code` for the gateway.

  The given module implements functionality for
  stripe as `hosted payment`. The code is returned
  for the same.
  > See
   `SnitchPayments.PaymentMethodCodes`
  """
  def payment_code do
    PaymentMethodCode.hosted_payment()
  end
end
