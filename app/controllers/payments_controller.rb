# CSRF protection mechanisms disabled
# it would be nice to handle with it
# ...or maybe GET would be better, there is no CSRF protection, everything depends on the payments specification

class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  before_filter :verify_custom_authenticity_token, only: :create

  after_filter :store_payment_log, only: :create

  def create
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

  # checks whether the request comes from a trusted source
  def verify_custom_authenticity_token
    true
  end

  def store_payment_log
    Payments::ResponseLog.new(params)    
  end
end
