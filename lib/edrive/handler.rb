# frozen_string_literal: true

require 'oj'

module Edrive
  # event handlers sample
  class Handler
    class << self
      # hash to json
      # @return [Proc] proc hash to json
      def hash2json
        ->(hash) { Oj.dump(hash, :compat) }
      end

      # json to hash
      # @return [JSON] proc json to hash
      def json2hash
        ->(json) { Oj.load(json) }
      end
    end
  end
end
