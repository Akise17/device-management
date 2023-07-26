module ApiException
  module Handler
    def self.included(klass)
      klass.class_eval do
        ApiException::BaseError.descendants.each do |error_class|
          rescue_from error_class do |err|
            render status: err.status_code, json: { error_code: err.error_code, message: err.message }
          end
        end
      end
    end
  end

  class BaseError < StandardError
    attr_reader :status_code, :error_code
  end

  class BadRequest < BaseError
    def initialize(msg = nil)
      @status_code = 401
      @error_code = 40_101
      msg ||= 'Your own message in here'
      super
    end
  end

  class Unauthorized < BaseError
    def initialize(msg = nil)
      @status_code = 401
      @error_code = 40_101
      msg ||= 'Not Authorized'
      super
    end
  end

  class Forbidden < BaseError
    def initialize(msg = nil)
      @status_code = 403
      @error_code = 40_301
      msg ||= 'Your own message in here'
      super
    end
  end

  class NotFound < BaseError
    def initialize(msg = nil)
      @status_code = 404
      @error_code = 40_401
      msg ||= 'Your Data is not Found'
      super
    end
  end
end
