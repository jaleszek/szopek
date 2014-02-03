require 'spec_helper'

describe 'Payments' do
  let(:cart){ create(:cart_with_two_items )}
  let(:order){ create(:order_sent, cart_id: cart.id) }

  let(:success_params){
    {
      "orderID"=> order.id,
      "PAYID"=>"769159873",
      "NCSTATUS"=>"0",
      "NCERROR"=>"0",
      "ACCEPTANCE"=>"057881",
      "STATUS"=>"7",
      "amount"=> order.total_cost.to_s,
      "currency"=>"CHF",
      "PM"=>"CreditCard",
      "BRAND"=>"Visa",
      "SHA1" => "ce7d0909f1772e84beb60284e25c11a1e7"
    }
  }

  describe 'GET /payments/finish' do
    context 'success payment' do
      before{ get(finish_payments_path, success_params) }

      it 'redirects to success page' do
        expect(response).to redirect_to(success_payments_path)
      end
    end

    context 'failed payment' do
      let(:failure_params){ success_params['STATUS'] = '1'; success_params }
      before{ get(finish_payments_path, failure_params) }

      it 'redirects to failure page' do
        expect(response).to redirect_to(failure_payments_path)
      end
    end
  end
end
