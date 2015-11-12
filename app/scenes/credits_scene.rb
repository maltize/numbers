class CreditsScene < BaseScene

  def didMoveToView(view)
    super

    add_credits_labels
    add_back_label
  end

  def add_credits_labels
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = "Credits"
    label.fontSize *= 1.25
    label.position = CGPointMake(mid_x, (max_y / 4) * 3)
    label.name = "credits"
    addChild label

    texture = SKTexture.textureWithImageNamed("profile-ak.png")
    image = SKSpriteNode.spriteNodeWithTexture(texture)
    image.position = CGPointMake(mid_x, (max_y / 8) * 4 + 48)
    image.name = 'profile-ak'
    image.size = CGSizeMake(48, 48)
    addChild image

    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Akshay Kumar"
    label.position = CGPointMake(mid_x, (max_y / 8) * 4)
    label.name = "ak"
    addChild label

    texture = SKTexture.textureWithImageNamed("profile-gs.png")
    image = SKSpriteNode.spriteNodeWithTexture(texture)
    image.position = CGPointMake(mid_x, (max_y / 8) * 3 + 48)
    image.name = 'profile-gs'
    image.size = CGSizeMake(48, 48)
    addChild image

    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Grzegorz Smajdor"
    label.position = CGPointMake(mid_x, (max_y / 8) * 3)
    label.name = "gs"
    addChild label

    texture = SKTexture.textureWithImageNamed("profile-mg.png")
    image = SKSpriteNode.spriteNodeWithTexture(texture)
    image.position = CGPointMake(mid_x, (max_y / 8) * 2 + 48)
    image.name = 'profile-mg'
    image.size = CGSizeMake(48, 48)
    addChild image

    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Maciej Gajek"
    label.position = CGPointMake(mid_x, (max_y / 8) * 2)
    label.name = "mg"
    addChild label
  end

  def add_back_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "back"
    label.fontSize *= 0.75
    label.position = CGPointMake(mid_x, (max_y / 8) * 1)
    label.name = "back"
    addChild label
  end

  def touchesBegan(touches, withEvent: event)
    touch = touches.anyObject
    location = touch.locationInNode(self)
    node = nodeAtPoint(location)

    if node.name == "back"
      scene = MenuScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    end
  end
end
