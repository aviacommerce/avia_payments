defmodule SnitchPayments.Response.HostedPayment do
  @moduledoc """
  Defines the reponse struct for hosted payments.

  All the calls to `parse_response/1` of any `hosted payment`
  gateway will return a `HostedPayment.t`.
  """
  defstruct [
    :payment_source,
    :transaction_id,
    :raw_response,
    :status,
    :order_id,
    :payment_id,
    :error_reason
  ]

  @typedoc """
  The standard response for hosted payment transactions.

  | Field          | Type              | Description                           |
  |----------------|-------------------|---------------------------------------|
  | `payment_source`| `String.t()`     | A string which represents the payment\
                                        source see `SnitchPayments.Provider`
  | `transaction_id`| `String.t()`     | transaction id of the payment        |
  | `raw_response`  | `map`            | Contains the entire response \
                                         from the gateway.
  | `status`        | String.t()       | Status whether payment is successful
                                        could be one of "success" or "failure"
  | `order_id`      | non_neg_integer  | `id` of the `order`                    |
  | `payment_id`    | non_neg_integer  | `id` of the `payment` to be updated with
                                         the response.
  | `error_reason`  | String.t()       | In case payment fails the reason depicts
                                         the reason for failure.
  """
  @type t :: %__MODULE__{
          payment_source: String.t(),
          transaction_id: String.t(),
          raw_response: map,
          status: String.t(),
          order_id: non_neg_integer,
          payment_id: non_neg_integer,
          error_reason: String.t()
        }
end
