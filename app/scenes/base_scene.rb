class BaseScene < SKScene

  def didMoveToView(view)
    super

    add_background
  end

  def add_background
    texture = SKTexture.textureWithImageNamed("numbers-bg.png")

    background = SKSpriteNode.spriteNodeWithTexture(texture)
    background.position = CGPointMake(mid_x, mid_y)
    background.name = "background"
    background.zPosition = -20
    background.scale = 1

    # background.color = UIColor.greenColor
    # background.colorBlendFactor = 0.5

    # Loop over colors?
    # colorize = SKAction.colorizeWithColor(UIColor.greenColor, colorBlendFactor: 0.5, duration: 5)
    # background.runAction(colorize)

    addChild background
  end

  def add_shadow
    texture = SKTexture.textureWithImageNamed("numbers-shadow.png")

    shadow = SKSpriteNode.spriteNodeWithTexture(texture)
    shadow.position = CGPointMake(mid_x, mid_y)
    shadow.name = "shadow"
    shadow.zPosition = 20
    shadow.scale = 1

    addChild shadow
  end

  def remove_shadow
    shadow = childNodeWithName('shadow')
    removeChild shadow
  end

  def max_level
    (max_rows * max_columns) - max_rows - 2
  end

  def font_size_multiplier
    base = 32
    default = 2
    default - (max_rows * max_columns).to_f / base
  end

  def shake
    5
  end

  def max_rows
    3
  end

  def max_columns
    6
  end

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
