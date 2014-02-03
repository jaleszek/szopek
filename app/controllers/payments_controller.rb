class PaymentsController < ApplicationController
  after_filter :store_payment_log, only: :process

  def finish
    payment = PaymentsHandler.new(params)
    payment.perform

    redirect_to (payment.success? ? success_payments_path : failure_payments_path)
  end

  def failure
    render(text: 'failure')
  end

  def success
    render(text: 'success')
  end

  private

  def store_payment_log
    Payments::ResponseLog.new(params)    
  end
end
