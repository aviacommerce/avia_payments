defmodule SnitchPayments.Factory.RazorPay do
  defmacro __using__(_) do
    quote do
      def rzpay_success_response() do
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"id\":\"pay_BMTbai06G4BN2C\",\"entity\":\"payment\",\"amount\":2000,\"currency\":\"INR\",\"status\":\"captured\",\"order_id\":null,\"invoice_id\":null,\"international\":false,\"method\":\"card\",\"amount_refunded\":0,\"refund_status\":null,\"captured\":true,\"description\":\"Purchase Description\",\"card_id\":\"card_BMTbak3ruu4OWV\",\"card\":{\"id\":\"card_BMTbak3ruu4OWV\",\"entity\":\"card\",\"name\":\"Gaurav Kumar\",\"last4\":\"1111\",\"network\":\"Visa\",\"type\":\"debit\",\"issuer\":null,\"international\":false,\"emi\":false},\"bank\":null,\"wallet\":null,\"vpa\":null,\"email\":\"arjun289singh@gmail.com\",\"contact\":\"+919923913937\",\"notes\":{\"address\":\"Hello World\"},\"fee\":40,\"tax\":0,\"error_code\":null,\"error_description\":null,\"created_at\":1542350096}",
           headers: [
             {"Cache-Control", "max-age=0, must-revalidate, no-store, nocache, private"},
             {"Content-Type", "application/json"},
             {"Date", "Fri, 16 Nov 2018 06:35:59 GMT"},
             {"Expires", "Fri, 01 Jan 1990 00:00:00 GMT"},
             {"Pragma", "no-cache"},
             {"Server", "Apache/2.4.35 (Unix)"},
             {"X-Frame-Options", "SAMEORIGIN"},
             {"Content-Length", "679"},
             {"Connection", "keep-alive"}
           ],
           request_url:
             "https://rzp_test_5DVuxqOKRl27pF:NM2EAPkSmDvu655qBa7oLmah@api.razorpay.com/v1/payments/pay_BMTbai06G4BN2C/capture",
           status_code: 200
         }}
      end

      def rzpay_failure_response_401() do
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"error\":{\"code\":\"BAD_REQUEST_ERROR\",\"description\":\"The api key provided is invalid\"}}",
           headers: [
             {"Cache-Control", "max-age=0, must-revalidate, no-store, nocache, private"},
             {"Content-Type", "application/json"},
             {"Date", "Fri, 16 Nov 2018 06:37:53 GMT"},
             {"Expires", "Fri, 01 Jan 1990 00:00:00 GMT"},
             {"Pragma", "no-cache"},
             {"Server", "Apache/2.4.35 (Unix)"},
             {"X-Frame-Options", "SAMEORIGIN"},
             {"Content-Length", "86"},
             {"Connection", "keep-alive"}
           ],
           request_url:
             "https://rzp_test_5DVuxqOKRl:NM2EAPkSmDvu655qBa7oLmah@api.razorpay.com/v1/payments/pay_BMTbai06G4BN2C/capture",
           status_code: 401
         }}
      end

      def rzpay_failure_paymentid_invalid() do
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"error\":{\"code\":\"BAD_REQUEST_ERROR\",\"description\":\"BMTbai06G is not a valid id\"}}",
           headers: [
             {"Cache-Control", "max-age=0, must-revalidate, no-store, nocache, private"},
             {"Content-Type", "application/json"},
             {"Date", "Mon, 19 Nov 2018 09:38:01 GMT"},
             {"Expires", "Fri, 01 Jan 1990 00:00:00 GMT"},
             {"Pragma", "no-cache"},
             {"Server", "Apache/2.4.35 (Unix)"},
             {"X-Frame-Options", "SAMEORIGIN"},
             {"Content-Length", "82"},
             {"Connection", "keep-alive"}
           ],
           request_url:
             "https://rzp_test_5DVuxqOKRl27pF:NM2EAPkSmDvu655qBa7oLmah@api.razorpay.com/v1/payments/pay_BMTbai06G/capture",
           status_code: 400
         }}
      end
    end
  end
end
