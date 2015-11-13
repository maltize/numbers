# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require './.key'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'numbers'
  app.icons = ['Icon.png', 'Icon@2x.png', 'Icon@3x.png']
  # app.info_plist['CFBundleIconFile'] = 'Icon.icns'

  app.frameworks += ["SpriteKit"]
  app.interface_orientations = [:portrait]

  app.identifier = IDENTIFIER
  app.provisioning_profile = PROVISIONING_PROFILE
end
