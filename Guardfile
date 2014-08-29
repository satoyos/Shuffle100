# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'motion' do
  watch(%r{^spec/.+_spec\.rb$})

  watch(%r{^app/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/models/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }

  # dataSources, delegates for screens
  watch(%r{^app/dataSources/(.+)_data_source\.rb$})     { |m| "spec/screens/#{m[1]}_spec.rb" }
  watch(%r{^app/delegates/(.+)_delegate\.rb$})     { |m| "spec/screens/#{m[1]}_spec.rb" }


  # RubyMotion App example
end
