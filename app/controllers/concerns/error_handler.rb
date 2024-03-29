# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern
  included do
    rescue_from Exceptions::UserNotFoundError do |e|
      respond(:not_found, e)
    end
  end

  private

  def respond(status, message)
    render json: jsonfied_error(status, message), status: status
  end

  def error_code_and_name(status)
    code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    name = Rack::Utils::HTTP_STATUS_CODES[code]
    [code, name]
  end

  def jsonfied_error(status, error)
    code, name = error_code_and_name(status)
    {
      status: code,
      error: name,
      details: {
        message: error.message
      }
    }
  end
end