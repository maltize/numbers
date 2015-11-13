class MenuScene < BaseScene

  def didMoveToView(view)
    super

    add_title_image
    add_start_label
    add_difficulty_labels
    add_credits_label
    view.score = 0
    if view.high_score > 0
      add_high_score_label
    end
  end

  def add_title_image
    texture = SKTexture.textureWithImageNamed("numbers-title.png")
    image = SKSpriteNode.spriteNodeWithTexture(texture)
    image.position = CGPointMake(mid_x, (max_y / 4) * 3)
    image.name = "numbers"
    image.scale = 0.5
    addChild image
  end

  def add_start_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Start Game"
    label.position = CGPointMake(mid_x, (max_y / 8) * 4)
    label.name = "start"
    addChild label
  end

  def add_difficulty_labels
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Difficulty #{self.view.difficulty}"
    label.position = CGPointMake(mid_x, (max_y / 8) * 3)
    label.name = "difficulty"
    addChild label

    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "❰❰❰"
    label.position = CGPointMake((max_x / 16) * 2, (max_y / 8) * 3)
    label.name = "decrease_difficulty"
    addChild label

    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "❱❱❱"
    label.position = CGPointMake((max_x / 16) * 14, (max_y / 8) * 3)
    label.name = "increase_difficulty"
    addChild label
  end

  def add_credits_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Credits"
    label.position = CGPointMake(mid_x, (max_y / 8) * 2)
    label.name = "credits"
    addChild label
  end

  def add_high_score_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = "Best score: #{self.view.high_score}"
    label.position = CGPointMake(mid_x, (max_y / 8) * 1)
    label.name = "highscore"
    addChild label
  end

  def update(current_time)
    @delta = @last_update_time ? current_time - @last_update_time : 0
    @last_update_time = current_time
  end

  def touchesBegan(touches, withEvent: event)
    touch = touches.anyObject
    location = touch.locationInNode(self)
    puts "touch at x: #{location.x}, y: #{location.y}"
    node = nodeAtPoint(location)
    puts node.name

    if node.name == "start"
      scene = CountDownScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    elsif node.name == "increase_difficulty"
      self.view.difficulty += 1 if self.view.difficulty < max_level
      difficulty_label = childNodeWithName('difficulty')
      difficulty_label.text = "Difficulty #{self.view.difficulty}"
    elsif node.name == "decrease_difficulty"
      self.view.difficulty -= 1 if self.view.difficulty > 1
      difficulty_label = childNodeWithName('difficulty')
      difficulty_label.text = "Difficulty #{self.view.difficulty}"
    elsif node.name == "credits"
      scene = CreditsScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    end

  end
end
