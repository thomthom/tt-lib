module SkippyLib
  # @since 3.0.0
  class ObjectUtils

    private

    # @return [String]
    # @since 3.0.0
    def object_id_hex
      format('0x%<id>x', id: (self.object_id << 1))
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

  end # class
end # module
