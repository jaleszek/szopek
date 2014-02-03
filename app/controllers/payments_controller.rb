# Action #create is open for every external request because anti-csrf mechanisms are disabled.
# Way of veryfing if given requests came from trusted source depends on payments specification.
# It can use whitelist, some checksum, token.

class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  before_filter :verify_custom_authenticity_token, only: :create
  after_filter :store_payment_log, only: :create

  def create
    response = Payments::Response.new(params)
    evaluator = Payments::ResponseEvaluator.new(response)

    order = evaluator.order

    if evaluator.success?
      order.mark_as_paid
      redirection_url = success_payments_path
    else
      order.try(:mark_as_failed)
      redirection_url = failure_payments_path
    end

    redirect_to redirection_url
  end

  def failure
    render(text: 'failure')
  end

  def success
    render(text: 'success')
  end

  private

  def verify_custom_authenticity_token
    # checks whether the request comes from a trusted source
    true
  end

  def store_payment_log
    Payments::ResponseLog.new(params)    
  end
end
