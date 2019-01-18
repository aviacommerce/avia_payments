defmodule SnitchPayments.Gateway.RazorPayTest do
  use ExUnit.Case

  import SnitchPayments.Factory
  import Mock

  alias SnitchPayments.Gateway.RazorPay
  alias SnitchPayments.Response.HostedPayment

  test "payment_code/0 returns payment code for razor_pay" do
    code = RazorPay.payment_code()
    assert code == "hpm"
  end

  describe "purchase/3" do
    test "successful capture with right params" do
      with_mock(HTTPoison,
        post: fn _, _ ->
          rzpay_success_response()
        end
      ) do
        params = %{amount: Money.new!(:INR, 20), payment_id: "pay_BMTbai06G4BN2C"}
        key_id = "rzp_test_5DVuxqOKR123pF"
        key_secret = "MN2AEPkSmDvu655qBa7oLham"
        assert {:ok, result} = RazorPay.purchase(params, key_id, key_secret)
        assert result["status"] == "captured"
      end
    end

    test "fails for invalid key_id, status 401" do
      with_mock(HTTPoison,
        post: fn _, _ ->
          rzpay_failure_response_401()
        end
      ) do
        params = %{amount: Money.new!(:INR, 20), payment_id: "pay_BMTbai06G4BN2C"}
        key_id = "rzp_test_5DVuxqOKR"
        key_secret = "MN2AEPkSmDvu655qBa7"
        assert {:error, result} = RazorPay.purchase(params, key_id, key_secret)
        assert result["error"]["description"] == "The api key provided is invalid"
      end
    end

    test "fails for invalid data, status 400" do
      with_mock(HTTPoison,
        post: fn _, _ ->
          rzpay_failure_paymentid_invalid()
        end
      ) do
        params = %{amount: Money.new!(:INR, 20), payment_id: "pay_BMTbai06G"}
        key_id = "rzp_test_5DVuxqOKR"
        key_secret = "MN2AEPkSmDvu655qBa7"
        assert {:error, result} = RazorPay.purchase(params, key_id, key_secret)
        assert result["error"]["description"] == "BMTbai06G is not a valid id"
      end
    end
  end

  describe "parse_response/1" do
    test "successful capture" do
      {:ok, response} = rzpay_success_response()

      response =
        response.body
        |> Poison.decode!()
        |> Map.put("status", "success")
        |> Map.put("order_id", "123")
        |> Map.put("payment_id", "342")
        |> Map.put("payment_source", "razor_pay")

      result = %HostedPayment{} = RazorPay.parse_response(response)
      assert result.status == "success"
    end

    test "error in capture" do
      {:ok, response} = rzpay_failure_paymentid_invalid()

      response =
        response.body
        |> Poison.decode!()
        |> Map.put("status", "failure")
        |> Map.put("order_id", "123")
        |> Map.put("payment_id", "342")
        |> Map.put("payment_source", "razor_pay")

      assert result = %HostedPayment{} = RazorPay.parse_response(response)
      assert result.status == "failure"
    end
  end
end
