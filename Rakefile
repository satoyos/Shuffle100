# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  require 'bubble-wrap/core'
#  Bundler.require
rescue LoadError
end

is_test = ARGV.join(' ') =~ /spec/
if is_test
  require 'guard/motion'
  Bundler.require :default, :spec
else
  Bundler.require
end


Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Shuffle100'

  app.frameworks += ['AVFoundation', 'AudioToolbox']

  if is_test
#    app.redgreen_style = :full
    app.redgreen_style = :focused
  end
end
