# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")
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

  app.deployment_target = '12.2'

  app.frameworks += ['AVFoundation', 'AudioToolbox', 'MediaPlayer']
  app.frameworks += ['QuartzCore']

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

  force_64bit_only!(app)

  app.info_plist['UIBackgroundModes'] = [
      'audio'
  ]

  app.pods {
    pod 'BBBadgeBarButtonItem', git: 'https://github.com/TanguyAladenise/BBBadgeBarButtonItem.git'
    # pod 'Reveal-SDK', :configurations => ['Debug'] # Use this only if needed on debuggng
    # DO NOT FORGET TO DELETE THIS before release and NUKE
  }

  APP_VERSION = '5.2'

  MotionProvisioning.output_path = '../my_provisioning'

  app.development do
    app.version = build_number
    app.short_version = APP_VERSION + 'β' + ".#{build_number}"
    app.codesign_certificate = MotionProvisioning.certificate(
        type: :development,
        platform: :ios)
    app.provisioning_profile = MotionProvisioning.profile(
        bundle_identifier: app.identifier,
        app_name: app.name,
        platform: :ios,
        type: :development)
  end

  app.release do
    app.info_plist['AppStoreRelease'] = true
    app.version = build_number
    app.short_version = APP_VERSION
    app.entitlements['beta-reports-active'] = true

    app.codesign_certificate = MotionProvisioning.certificate(
        type: :distribution,
        platform: :ios)

    app.provisioning_profile = MotionProvisioning.profile(
        bundle_identifier: app.identifier,
        app_name: app.name,
        platform: :ios,
        type: :distribution)
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

def force_64bit_only!(app)
  # This is required as of iOS 11.0, 32 bit compilations will no
  # longer be allowed for submission to the App Store.

  app.archs['iPhoneOS'] = ['arm64']
  app.info_plist['UIRequiredDeviceCapabilities'] = ['arm64']
end