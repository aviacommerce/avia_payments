defmodule SnitchPayments.Gateway.StripeTest do
  use ExUnit.Case
  alias SnitchPayments.Gateway.Stripe

  test "preferences/0 returns credentials for stripe" do
    [key | _] = Stripe.preferences()
    assert key == :secret_key
  end

  test "payment_code/0 returns payment code for stripe" do
    code = Stripe.payment_code()
    assert code == "hpm"
  end
end
