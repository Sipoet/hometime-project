class BaseService

  attr_reader :result

  def initialize(response: nil)
    @result = response || JsonResponse.new
    raise 'response must form response class' unless @result.is_a?(Response)
  end

  def execute(params)
    call(params)
  rescue => e
    Rails.logger.error("error: #{e.message} backtrace: #{e.backtrace[0..5].inspect}")
    add_error(title: 'server error', message: e.message)
  end

  def self.run(params, response: nil)
    service = self.new(response: response)
    service.execute(params)
    result = service.result
    raise 'response not initiated' if result.status.blank?
    result
  end

  protected

  def call(params)
    raise 'implement call must on parent class'
  end

  def add_error(title: 'failed to save', message:)
    @result.failed!
    @result.add_error(status: 400, title: title, detail: message)
  end

  class ValidationError < StandardError;end
end