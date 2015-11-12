class GameScene < BaseScene

  def didMoveToView(view)
    super

    add_title_label
  end

  def add_title_label
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = "DaGame"
    label.position = CGPointMake(mid_x, mid_y)
    label.name = "dagame"
    addChild label
  end

end
