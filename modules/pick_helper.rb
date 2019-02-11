module SkippyLib
  # @since 3.0.0
  module PickHelper

    # @param [Sketchup::View] view
    def self.new(view)
      # TODO: Don't do this! `Sketchup::PickHelper` objects are reused. Cannot
      # use `extend` as it with modify the global persistent object.
      raise NotImplementedError
      # pick_helper = view.pick_helper
      # pick_helper.extend(self)
      # pick_helper
    end

    # Return unique set of leaves from the pick paths.
    # @return [Array<Entity>]
    def leaves
      all_picked.uniq
    end

    # @return [Array<Array<Entity>>]
    def paths
      Array.new(count) { |i| path_at(i) }
    end

  end
end # module
