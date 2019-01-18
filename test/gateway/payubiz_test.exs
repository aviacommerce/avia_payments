defmodule SnitchPayments.Gateway.PayuBizTest do
  use ExUnit.Case
  alias SnitchPayments.Gateway.PayuBiz
  alias SnitchPayments.Response.HostedPayment
  import SnitchPayments.Factory

  test "preferences/0 returns credentials for payubiz" do
    [key1, key2] = PayuBiz.preferences()
    assert key1 == :merchant_key
    assert key2 == :salt
  end

  test "payment_code/0 returns payment code for payubiz" do
    code = PayuBiz.payment_code()
    assert code == "hpm"
  end

  test "parse_response/1 returns data in fixed format", context do
    params = payubiz_success_response(context)
    response = %HostedPayment{} = PayuBiz.parse_response(params)

    assert response.status == params["status"]
    assert response.transaction_id == params["mihpayid"]
    assert response.order_id == String.to_integer(params["order_id"])
    assert response.payment_id == String.to_integer(params["payment_id"])
  end
end
