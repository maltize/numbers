class CountDownScene < SKScene

  def didMoveToView(view)
    super

    add_background
    add_title_label
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

  def add_title_label
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = "DUPA"
    label.position = CGPointMake(mid_x, 500) # Should calculate this dynamically based on screen size
    label.name = "title"
    addChild label
  end

  def update(current_time)
    @delta = @last_update_time ? current_time - @last_update_time : 0
    puts 'scene 2'
    puts @delta
    @last_update_time = current_time
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
