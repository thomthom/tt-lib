# TODO: Copied from sketchup-yard-template. Convert into reusable gem.

require 'set'

include Helpers::ModuleHelper

def init
  find_all_versions
end


def all_objects
  run_verifier(Registry.all)
end


def find_all_versions
  versions = Set.new
  all_objects.each { |object|
    version_tag = object.tag(:since)
    versions << version_tag.text if version_tag
  }
  puts versions.sort.join("\n")
  exit # Avoid the YARD summary
end
