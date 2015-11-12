class GameScene < SKView

  def didMoveToView(view)
    super

    add_title_label
  end

  def add_title_label
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = "DaGame"
    label.position = CGPointMake(mid_x, 500) # Should calculate this dynamically based on screen size
    label.name = "dagame"
    addChild label
  end


  def game
  end

  # Helper methods.
  #
  def mid_x
    CGRectGetMidX(self.frame)
  end

  def mid_y
    CGRectGetMidY(self.frame)
  end
end
