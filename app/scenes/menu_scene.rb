class MenuScene < SKScene

  def didMoveToView(view)
    super

    add_background
    add_title_label
    add_start_label
    add_difficulty_label
    add_credits_label
  end

  def add_title_label
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = "Numbers"
    label.fontSize *= 1.5
    label.position = CGPointMake(mid_x, (max_y / 4) * 3)
    label.name = "numbers"
    addChild label
  end

  def add_start_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Start"
    label.position = CGPointMake(mid_x, (max_y / 8) * 4)
    label.name = "start"
    addChild label
  end

  def add_difficulty_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Difficulty"
    label.position = CGPointMake(mid_x, (max_y / 8) * 3)
    label.name = "difficulty"
    addChild label
  end

  def add_credits_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Credits"
    label.position = CGPointMake(mid_x, (max_y / 8) * 2)
    label.name = "credits"
    addChild label
  end

  def add_background
    texture = SKTexture.textureWithImageNamed("numbers-bg.png")

    background = SKSpriteNode.spriteNodeWithTexture(texture)
    background.position = CGPointMake(mid_x, mid_y)
    background.name = "background"
    background.zPosition = -20
    background.scale = 1

    addChild background
  end

  def update(current_time)
    @delta = @last_update_time ? current_time - @last_update_time : 0
    @last_update_time = current_time
  end

  def touchesBegan(touches, withEvent: event)
    puts "You touched me!"

    touch = touches.anyObject
    location = touch.locationInNode(self)
    puts "touch at x: #{location.x}, y: #{location.y}"
    node = nodeAtPoint(location)
    puts node.name

    if node.name == "numbers"
      scene = CountDownScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    else
      # I don't now :)
    end

  end

  # Helper methods.
  #
  def mid_x
    CGRectGetMidX(self.frame)
  end

  def mid_y
    CGRectGetMidY(self.frame)
  end

  def max_x
    CGRectGetMaxX(self.frame)
  end

  def max_y
    CGRectGetMaxY(self.frame)
  end
end
