class Response
  attr_reader :status, :errors

  def initialize
    @errors = []
  end

  def success!
    @status = :success
  end

  def failed!
    @status = :failed
  end

  def success?
    @status == :success
  end

  def failed?
    @status == :failed
  end

  def add_error(error)
    @errors << error
  end
end