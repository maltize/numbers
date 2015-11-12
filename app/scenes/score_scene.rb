class ScoreScene < BaseScene
  def didMoveToView(view)
    super

    view.update_high_score(view.score)
    add_scores_titles(view.score, view.high_score)
    add_back_to_main_menu_label
    add_try_again_label
  end

  def add_scores_titles(your_score, high_score)
    your_score_label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    your_score_label.text = "Score: #{your_score}"
    your_score_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    your_score_label.position = CGPointMake((max_x / 6), (max_y / 12) * 10)
    addChild your_score_label

    high_score_label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    high_score_label.text = "High Score: #{high_score}"
    high_score_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    high_score_label.position = CGPointMake((max_x / 6), (max_y / 12) * 9)
    addChild high_score_label
  end

  def add_back_to_main_menu_label
    label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    label.text = 'Back to Menu'
    label.position = CGPointMake(mid_x, (max_y / 12) * 3)
    label.name = 'back'
    addChild label
  end

  def add_try_again_label
    label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    label.text = 'Try Again'
    label.position = CGPointMake(mid_x, (max_y / 12) * 4)
    label.name = 'tryagain'
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
