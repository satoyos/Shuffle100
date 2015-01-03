# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
require 'sugarcube-common'

in_simulator = in_spec = nil

case ARGV.join(' ')
  when /spec/
    in_spec = true
    require 'awesome_print_motion'
    Bundler.require :spec
  when /frank/
    Bundler.require :frank
  when /simulator|device|pod/
    in_simulator = true
    require 'awesome_print_motion'
    Bundler.require :simulator
end

Bundler.require

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

  APP_VERSION = '2.5.1'

  app.development do
    app.pods {
      pod 'Reveal-iOS-SDK'
    } if in_simulator
    app.version = build_number
    app.short_version = APP_VERSION + 'β' + ".#{build_number})"
    app.codesign_certificate = 'iPhone Developer: Yoshifumi Sato'
    app.provisioning_profile = '/Users/yoshi/data/dev/Provisionings/Provisioning_for_100series_Tester.mobileprovision'
  end

  app.release do
    app.info_plist['AppStoreRelease'] = true
    app.version = build_number
    app.short_version = APP_VERSION
    app.codesign_certificate = 'iPhone Distribution: Yoshifumi Sato'
    app.provisioning_profile = '/Users/yoshi/data/dev/Provisionings/Shuffle100_Distribution.mobileprovision'
    app.entitlements['beta-reports-active'] = true
  end

  app.detect_dependencies = true

  app.redgreen_style = :focused if in_spec
end

def build_number
  Time.now.strftime('%Y%m%d.%H%M')
end
