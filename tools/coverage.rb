puts 'COVERAGE: Preparing to run coverage tests...'

puts "COVERAGE: Working Directory: #{Dir.pwd} (#{Dir.getwd})"

solution_path = File.expand_path('..', __dir__)
ruby_source_path = File.join(solution_path, 'src')
ruby_tests_path = File.join(solution_path, 'tests')
test_suite_path = File.join(ruby_tests_path, 'TT_Lib')

puts 'COVERAGE: Loading SimpleCov...'

# https://github.com/colszowka/simplecov
require 'simplecov'
SimpleCov.root(solution_path)
SimpleCov.start do
  add_filter '/tests/'
  add_filter 'skippylib.rb'
  # TODO: Set up groups.
  # add_group 'Debugging', 'src/tt_shadow_texture/debugging'
  # add_group 'Image', 'src/tt_shadow_texture/image'
  # add_group 'Shadows', /\/shadow_/
end

puts 'COVERAGE: Loading extension...'

$LOAD_PATH << ruby_source_path
Dir.glob("#{ruby_source_path}/**/*.rb") do |filename|
  require filename
end

done = false
UI.start_timer(0.0, false) {
  next if done

  done = true

  puts 'COVERAGE: Loading TestUp...'

  require 'testup'
  # TODO: Check TestUp version.

  puts 'COVERAGE: Running tests...'

  TestUp::API.run_suite_without_gui(test_suite_path)

  puts 'COVERAGE: Terminating...'

  Sketchup.active_model.close(true) # Force close the test model.
  Sketchup.quit
}
