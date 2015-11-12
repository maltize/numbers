class ScoreScene < SKScene
  def didMoveToView(view)
    super

    add_scores_titles(1000, 10000)
    add_background
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

  def add_background
    texture = SKTexture.textureWithImageNamed('numbers-bg.png')

    background = SKSpriteNode.spriteNodeWithTexture(texture)
    background.position = CGPointMake(mid_x, mid_y)
    background.name = 'background'
    background.zPosition = -20
    background.scale = 1

    addChild background
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
