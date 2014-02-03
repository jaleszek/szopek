class FakeResponseBuilder
  def self.build_successful(order = OpenStruct.new(id: 1, total_cost: 10.0))
    {
        "orderID"=>"#{order.id}", 
        "PAYID"=>"769159873", 
        "NCSTATUS"=>"0", 
        "NCERROR"=>"0", 
        "ACCEPTANCE"=>"057881", 
        "STATUS"=>"7",  
        "amount"=>"#{order.total_cost}", 
        "currency"=>"CHF", 
        "PM"=>"CreditCard", 
        "BRAND"=>"Visa", 
        "SHA1" => "ce7d0909f1772e84beb60284e25c11a1e7" 
      }
  end
end
