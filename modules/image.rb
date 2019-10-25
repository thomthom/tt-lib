# frozen_string_literal: true

module SkippyLib
  # @since 3.0.0
  module Image

    # This module is deliberately not a mix-in.

    # @param [Sketchup::Image] image
    # @return [Sketchup::Material]
    # @sketchup 2018
    # @since 3.0.0
    def self.clone_material(image, name: nil, force: false)
      definition = self.definition(image)
      material_name = name || "Copy of #{definition.name}"
      model = image.model
      # Reuse existing materials if it exists. Only checking for existing names.
      if force
        material = model.materials[material_name]
        return material if material
      end
      # Note that materials.add create unique names on demand.
      material = model.materials.add(material_name)
      # rubocop:disable SketchupSuggestions/Compatibility
      material.texture = image.image_rep
      # rubocop:enable SketchupSuggestions/Compatibility
      material
    end

    # @param [Sketchup::Image] image
    # @return [Sketchup::ComponentDefinition]
    # @since 3.0.0
    def self.definition(image)
      image.model.definitions.find { |definition|
        definition.image? && definition.instances.include?(image)
      }
    end

  end # module
end # module
