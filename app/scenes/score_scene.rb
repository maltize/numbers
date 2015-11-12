class ScoreScene < BaseScene
  def didMoveToView(view)
    super

    view.update_high_score(view.score)
    add_scores_titles(view.score, view.high_score)
    add_try_again_label
    add_back_label
  end

  def add_scores_titles(your_score, high_score)
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = "Game Over"
    label.fontSize *= 1.25
    label.position = CGPointMake(mid_x, (max_y / 4) * 3)
    label.name = "hiscore"
    addChild label

    label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    label.text = "Your score: #{your_score}"
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    label.position = CGPointMake((max_x / 6), (max_y / 16) * 8)
    addChild label

    label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    label.text = "High Score: #{high_score}"
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    label.position = CGPointMake((max_x / 6), (max_y / 16) * 7)
    addChild label
  end

  def add_try_again_label
    label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    label.text = 'Try Again'
    label.fontSize *= 1.5
    label.position = CGPointMake(mid_x, (max_y / 16) * 4)
    label.name = 'tryagain'
    addChild label
  end

  def add_back_label
    label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    label.text = 'Menu'
    label.fontSize *= 1.5
    label.position = CGPointMake(mid_x, (max_y / 16) * 2)
    label.name = 'back'
    addChild label
  end

  def touchesBegan(touches, withEvent: event)
    touch = touches.anyObject
    location = touch.locationInNode(self)
    node = nodeAtPoint(location)

    if node.name == 'back'
      scene = MenuScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    elsif node.name == 'tryagain'
      self.view.score = 0
      scene = CountDownScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    end
  end
end
