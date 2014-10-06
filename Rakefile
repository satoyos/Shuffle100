# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'

is_test = ARGV.join(' ') =~ /spec|frank/
if is_test
  require 'guard/motion'
  require 'motion-frank'
  Bundler.require :default, :spec
 else
  Bundler.require
 end

require 'sugarcube-common'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Shuffle100'

  app.deployment_target = '7.0'

  app.frameworks += ['AVFoundation', 'AudioToolbox']
  app.frameworks += ['QuartzCore']

  # app.icons = ['Shuffle100.png', 'Shuffle100@2x.png', 'Shuffle100-60@2x.png']
  app.prerendered_icon = true
  app.icons = Dir.glob('resources/Icon*.png').map{|icon| icon.split('/').last}

  app.identifier = 'com.sato0123.Shuffle100'
  app.device_family = [:iphone, :ipad]

  app.info_plist['CFBundleURLTypes'] = [
      { 'CFBundleURLName' => 'com.satoyos.Shuffle100',
        'CFBundleURLSchemes' => ['Shuffle100'] }
  ]

  APP_VERSION = '2.3'

  app.development do
    app.version = submit_version(APP_VERSION) + 'β'
    app.short_version = APP_VERSION + 'β'
    app.codesign_certificate = 'iPhone Developer: Yoshifumi Sato'
    app.provisioning_profile = '/Users/yoshi/data/dev/Provisionings/Provisioning_for_100series_Tester_2014-09-21.mobileprovision'
  end

  app.release do
    app.info_plist['AppStoreRelease'] = true
    app.version = submit_version(APP_VERSION)
    app.short_version = APP_VERSION
    app.codesign_certificate = 'iPhone Distribution: Yoshifumi Sato'
    app.provisioning_profile = '/Users/yoshi/data/dev/Provisionings/Provisioning_for_Shuffle100_Distribution.mobileprovision'
  end

  app.detect_dependencies = true

  if is_test
#    app.redgreen_style = :full
    app.redgreen_style = :focused
  end
end

require 'date'

def submit_version(short_version)
  "#{short_version}_#{Date.today}"
end
