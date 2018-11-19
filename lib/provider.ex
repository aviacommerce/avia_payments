defmodule SnitchPayments.Provider do
  @moduledoc """
  Utilities for handling source(gateway) and the related
  modules to handle related functionalities.
  """

  @doc """
  Returns the source type for the supplied gateway :atom.

  The provider types helps in idenitfying the module to
  handle tasks such as response parsing for the particular
  source.
  """
  @spec provider(atom) :: String.t()
  def provider(gateway) do
    case gateway do
      :payubiz -> "payubiz"
      :stripe -> "stripe"
      :rzpay -> "razor_pay"
    end
  end

  def module("payubiz") do
    Elixir.SnitchPayments.Gateway.PayuBiz
  end

  def module("stripe") do
    Elixir.SnitchPayments.Gateway.Stripe
  end

  def module("razor_pay") do
    Elixir.SnitchPayments.Gateway.RazorPay
  end
end
