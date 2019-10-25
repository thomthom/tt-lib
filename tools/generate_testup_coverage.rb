# frozen_string_literal: true
require 'fileutils'

solution_path = File.expand_path('..', __dir__)
tests_path = File.join(solution_path, 'tests', 'TT_Lib')

command = %(yardoc -t coverage -f text -p yard-tools)

Dir.chdir(solution_path) do
  system(command)
end

source = File.join(solution_path, 'coverage.manifest')
target = tests_path
FileUtils.move(source, target, force: true, verbose: true)
