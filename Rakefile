# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
require 'bubble-wrap/core'
require 'rubygems'
require 'motion-stump'
require 'awesome_print_motion'
require 'motion-layout'
require 'motion-frank'


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
  app.frameworks += ['QuartzCore']

  app.icons = ['Shuffle100.png', 'Shuffle100@2x.png']
  app.prerendered_icon = true

  app.identifier = 'com.satoyos.Shuffle100'
  app.codesign_certificate = 'iPhone Developer: Yoshifumi Sato'
  app.provisioning_profile = '/Users/yoshi/data/dev/Provisioning_for_100series_Tester_with_iPad_Air.mobileprovision'

=begin
  app.vendor_project(
      'vendor/Reveal.framework',
      :static,
      :products => %w{Reveal},
      :headers_dir => 'Headers'
  )
=end

  app.release do
    app.info_plist['AppStoreRelease'] = true
  end

  if is_test
#    app.redgreen_style = :full
    app.redgreen_style = :focused
  end
end
