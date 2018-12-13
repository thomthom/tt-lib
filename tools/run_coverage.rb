# TODO: Support Mac
# TODO: Support argument for SketchUp version.

solution_path = File.expand_path('..', __dir__)

sketchup = 'C:\\Program Files\\SketchUp\\SketchUp 2018\\SketchUp.exe'
script = File.join(__dir__, 'coverage.rb')

command = %("#{sketchup}" -RubyStartup "#{script}")

Dir.chdir(solution_path) do
  id = spawn(command)
  Process.detach(id)
end
