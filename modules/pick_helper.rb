module SkippyLib
  # @since 3.0.0
  module PickHelper

    # @param [Sketchup::View]
    def self.new(view)
      pick_helper = view.pick_helper
      pick_helper.extend(self)
      pick_helper
    end

    # Return unique set of leaves from the pick paths.
    # @return [Array<Entity>]
    def leaves
      all_picked.uniq
    end

    # @return [Array<Array<Entity>>]
    def paths
      count.times.map { |i| path_at(i) }
    end

  end
end # module
