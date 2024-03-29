# frozen_string_literal: true

module SkippyLib
  # @since 3.0.0
  module ObjectUtils

    private

    # @return [String]
    # @since 3.0.0
    def object_id_hex
      format('0x%<id>.16x', id: self.object_id)
    end

    # @param [Hash] extra
    # @return [String]
    # @since 3.0.0
    def inspect_object(extra = {})
      meta = extra.map { |k, v| "#{k}: #{v}" }.join(' ')
      meta = " #{meta}" unless meta.empty?
      hex_id = object_id_hex
      "#<#{self.class.name}:#{hex_id}#{meta}>"
    end

  end # module
end # module
