defmodule SnitchPayments.Gateway do
  @moduledoc """
  A specification for gateway modules for snitch payments.

  The module exposes a set of functions to be implemented
  by all the modules adopting the behavior.
  """

  @callback preferences() :: list
  @callback payment_code() :: list
  @callback parse_response(map) :: SnitchPayments.Response.t()
end
