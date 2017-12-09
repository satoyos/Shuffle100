# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
require 'sugarcube-common'
require 'sugarcube-awesome'

def rake_mode
  case ARGV.join(' ')
    when /simulator|device|pod|\A\z/ ; :simulator
    when /spec/ ; :spec
  end
end

Bundler.require

case rake_mode
  when :spec
    require 'awesome_print_motion'
    Bundler.require :spec
  when :simulator
    require 'awesome_print_motion'
    Bundler.require :simulator
end

Motion::Project::App.setup do |app|
  app.name = 'Shuffle100'

  app.deployment_target = '10.0'

  app.frameworks += ['AVFoundation', 'AudioToolbox', 'MediaPlayer']
  app.frameworks += ['QuartzCore']

=begin
  app.prerendered_icon = true
  app.icons = Dir.glob('resources/Icon*.png').map{|icon| icon.split('/').last}
=end
  # app.info_plist['CFBundleIconName'] = 'AppIcon'
  define_icon_defaults!(app)

  app.fonts = ['fontawesome-webfont.ttf']

  app.identifier = 'com.sato0123.Shuffle100'
  app.device_family = [:iphone, :ipad]

  app.info_plist['AppStoreID'] = '857819404'
  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true }
  app.info_plist['UIRequiresFullScreen'] = 'YES'
  app.info_plist['ITSAppUsesNonExemptEncryption'] = false

  app.info_plist['CFBundleURLTypes'] = [
      { 'CFBundleURLName' => 'com.satoyos.Shuffle100',
        'CFBundleURLSchemes' => ['Shuffle100'] }
  ]

  app.info_plist['UIBackgroundModes'] = [
      'audio'
  ]

  app.pods {
    pod 'BBBadgeBarButtonItem', git: 'https://github.com/TanguyAladenise/BBBadgeBarButtonItem.git'
  }

  APP_VERSION = '4.31'

  app.development do
    app.version = build_number
    app.short_version = APP_VERSION + 'β' + ".#{build_number}"
    app.codesign_certificate = 'iPhone Developer: Yoshifumi Sato'
    app.provisioning_profile = ENV['PROVISIONING_PROFILE_DEVELOPMENT']
  end

  app.release do
    app.info_plist['AppStoreRelease'] = true
    app.version = build_number
    app.short_version = APP_VERSION
    app.codesign_certificate = 'iPhone Distribution: Yoshifumi Sato'
    app.provisioning_profile = ENV['PROVISIONING_PROFILE_DISTRIBUTION']
    app.entitlements['beta-reports-active'] = true
  end

  app.detect_dependencies = true

  app.redgreen_style = :focused if rake_mode == :spec
end

def define_icon_defaults!(app)
  app.info_plist['CFBundleIcons'] = {
      'CFBundlePrimaryIcon' => {
          'CFBundleIconName' => 'AppIcon',
          'CFBundleIconFiles' => ['AppIcon60x60']
      }
  }

  app.info_plist['CFBundleIcons~ipad'] = {
      'CFBundlePrimaryIcon' => {
          'CFBundleIconName' => 'AppIcon',
          'CFBundleIconFiles' => ['AppIcon60x60', 'AppIcon76x76']
      }
  }
end

def build_number
  Time.now.strftime('%Y.%m.%d.%H.%M')
end

