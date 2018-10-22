defmodule SnitchPayments.Factory.Stripe do
  defmacro __using__(_) do
    quote do
      def stripe_success_response() do
        %{
          "source" => %{
            "address_city" => nil,
            "address_country" => nil,
            "address_line1" => nil,
            "address_line1_check" => nil,
            "address_line2" => nil,
            "address_state" => nil,
            "address_zip" => "42424",
            "address_zip_check" => "pass",
            "brand" => "Visa",
            "country" => "US",
            "customer" => nil,
            "cvc_check" => "pass",
            "dynamic_last4" => nil,
            "exp_month" => 4,
            "exp_year" => 2024,
            "fingerprint" => "KWVUNsKhwlGoGUsY",
            "funding" => "credit",
            "id" => "card_1DNJjzGfnlO8QCOs03yNH6zM",
            "last4" => "4242",
            "metadata" => %{},
            "name" => nil,
            "object" => "card",
            "tokenization_method" => nil
          },
          "on_behalf_of" => nil,
          "application" => nil,
          "customer" => nil,
          "balance_transaction" => "txn_1DNJspGfnlO8QCOsLlmlNGIO",
          "review" => nil,
          "created" => 1_540_039_727,
          "statement_descriptor" => nil,
          "source_transfer" => nil,
          "amount" => 1000,
          "transfer_group" => nil,
          "payment_intent" => nil,
          "captured" => true,
          "outcome" => %{
            "network_status" => "approved_by_network",
            "reason" => nil,
            "risk_level" => "normal",
            "risk_score" => 1,
            "seller_message" => "Payment complete.",
            "type" => "authorized"
          },
          "id" => "ch_1DNJspGfnlO8QCOsDJaGfKcA",
          "amount_refunded" => 0,
          "receipt_number" => nil,
          "currency" => "usd",
          "refunds" => %{
            "data" => [],
            "has_more" => false,
            "object" => "list",
            "total_count" => 0,
            "url" => "/v1/charges/ch_1DNJspGfnlO8QCOsDJaGfKcA/refunds"
          },
          "paid" => true,
          "application_fee" => nil,
          "failure_code" => nil,
          "failure_message" => nil,
          "invoice" => nil,
          "shipping" => nil,
          "status" => "succeeded",
          "refunded" => false,
          "fraud_details" => %{},
          "description" => nil,
          "metadata" => %{},
          "livemode" => false,
          "object" => "charge",
          "dispute" => nil,
          "order" => nil,
          "destination" => nil,
          "receipt_email" => nil
        }
      end

      def stripe_error_token_used() do
        %{
          "error" => %{
            "code" => "token_already_used",
            "doc_url" => "https://stripe.com/docs/error-codes/token-already-used",
            "message" =>
              "You cannot use a Stripe token more than once: tok_1DNJjzGfnlO8QCOspPi7Xv22.",
            "type" => "invalid_request_error"
          }
        }
      end

      def stripe_error_cvc() do
        %{
          "error" => %{
            "charge" => "ch_1DNLQSGfnlO8QCOso6Jdk9l3",
            "code" => "incorrect_cvc",
            "doc_url" => "https://stripe.com/docs/error-codes/incorrect-cvc",
            "message" => "Your card's security code is incorrect.",
            "param" => "cvc",
            "type" => "card_error"
          }
        }
      end
    end
  end
end
