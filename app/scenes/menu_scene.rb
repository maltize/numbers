class MenuScene < BaseScene

  def didMoveToView(view)
    super

    add_title_label
    add_start_label
    add_difficulty_labels
    add_credits_label
    view.score = 0
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
    label.text = "New Game"
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
    label.text = "<"
    label.position = CGPointMake((max_x / 16) * 3, (max_y / 8) * 3)
    label.name = "decrease_difficulty"
    addChild label

    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = ">"
    label.position = CGPointMake((max_x / 16) * 13, (max_y / 8) * 3)
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
      self.view.difficulty += 1 if self.view.difficulty < 9
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
