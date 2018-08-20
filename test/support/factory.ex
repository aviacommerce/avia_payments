defmodule SnitchPayments.Factory do

  def payubiz_success_response(_context) do
    %{
      "source" => "payubiz",
      "order_id" => "1",
      "payment_id" => "1",
      "cardnum" => "401200XXXXXX1112",
      "productinfo" => "tshirt100",
      "amount" => "100.00",
      "name_on_card" => "Test",
      "hash" => "3c131dd06da0443a2833229db430f08e9ab0125cdf0eb458d9729c4516bdecc1c1d7c99f67cfd6e0577e98b5124047d54f87d36c52f91885d19ab4dfe1424b8e",
      "payment_source" => "payu",
      "error_Message" => "No Error",
      "firstname" => "Gopal",
      "zipcode" => "",
      "mihpayid" => "403993715518128964",
      "status" => "success",
      "discount" => "0.00",
      "addedon" => "2018-08-16 22:51:53",
      "bankcode" => "CC",
      "net_amount_debit" => "100",
      "email" => "gopal@aviabird.com",
      "card_type" => "VISA",
    }
  end
end
