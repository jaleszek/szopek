class PaymentsHandler
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def success?
    @success ||= evaluator.success?
  end

  def perform
    if success?
      order.mark_as_paid
    else
      order.try(:mark_as_failed)
    end
  end

  private

  def order
    @order ||= evaluator.order
  end

  def response
    Payments::Response.new(params)
  end

  def evaluator
    Payments::ResponseEvaluator.new(response)
  end
end
