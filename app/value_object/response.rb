class Response
  extend SimpleEnum::Attribute

  attr_reader :errors
  attr_accessor :status_cd

  as_enum :status, [:success, :failed, :not_found, :forbidden], map: :string

  def initialize
    @errors = []
  end

  def add_error(error)
    @errors << error
  end
end