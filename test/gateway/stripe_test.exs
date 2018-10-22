defmodule SnitchPayments.Gateway.StripeTest do
  use ExUnit.Case
  alias SnitchPayments.Gateway.Stripe

  import SnitchPayments.Factory
  import Mock

  @token "tok_visa"
  @secret ""
  @amount Money.new!(:USD, 10)
  @bad_csv_token "tok_cvcCheckFail"

  @params [
    receipt_email: "arjun289singh@gmail.com",
    address: %{
      street1: "123 Main",
      street2: "Suite 100",
      city: "New York",
      region: "NY",
      country: "US",
      postal_code: "11111"
    }
  ]

  test "preferences/0 returns credentials for stripe" do
    [key | _] = Stripe.preferences()
    assert key == :secret_key
  end

  test "payment_code/0 returns payment code for stripe" do
    code = Stripe.payment_code()
    assert code == "hpm"
  end

  describe "purchase/4" do
    test "successfull with right params" do
      with_mock Stripe,
        purchase: fn _, _, _, _ ->
          stripe_success_response()
        end do
        result = Stripe.purchase(@token, @secret, @amount, @params)
        assert result["paid"] == true
      end
    end

    test "unsuccessfull, wrong cvc" do
      with_mock Stripe,
        purchase: fn _, _, _, _ ->
          stripe_error_cvc()
        end do
        result = Stripe.purchase(@bad_csv_token, @secret, @amount, @params)
        assert result["error"]["code"] == "incorrect_cvc"
      end
    end

    test "unsuccessful, token already used" do
      with_mock Stripe,
        purchase: fn _, _, _, _ ->
          stripe_error_token_used()
        end do
        result = Stripe.purchase(@token, @secret, @amount, @params)
        assert result["error"]["code"] == "token_already_used"
      end
    end
  end

  describe "parse_response/1" do
    test "for error params" do
      response = stripe_error_token_used()

      params =
        response
        |> Map.put("order_id", "1")
        |> Map.put("payment_id", "1")
        |> Map.put("source", "stripe")

      result = Stripe.parse_response(params)
      assert result.status == "failed"
      refute is_nil(result.error_reason)
    end

    test "for success params" do
      response = stripe_success_response()

      params =
        response
        |> Map.put("order_id", "1")
        |> Map.put("payment_id", "1")
        |> Map.put("source", "stripe")

      result = Stripe.parse_response(params)
      assert result.status == "succeeded"
      assert result.paid == true
    end
  end
end
