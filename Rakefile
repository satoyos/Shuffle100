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

#  app.frameworks += ['AVFoundation', 'CoreAudio']
  app.frameworks += ['AVFoundation', 'AudioToolbox']

  app.identifier = 'com.satoyos.Shuffle100'
  app.codesign_certificate = 'iPhone Developer: Yoshifumi Sato'
  app.provisioning_profile = '/Users/yoshi/data/dev/Provisioning_for_100series_Tester_with_iPad_Air.mobileprovision'


  if is_test
    app.redgreen_style = :full
#    app.redgreen_style = :focused
  end
end
