# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'numbers'
  app.frameworks += ["SpriteKit"]
  app.interface_orientations = [:portrait]

  app.identifier = 'yelp.hackathon.Numbers'
  app.provisioning_profile = '/Users/maciej/Library/MobileDevice/Provisioning Profiles/c381cbb2-42c3-43e5-b192-befe704d4437.mobileprovision'
end
