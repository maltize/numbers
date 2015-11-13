class GuideScene < BaseScene

  def didMoveToView(view)
    super

    @page = 0
    add_guide_image
  end

  def add_guide_image
    texture = SKTexture.textureWithImageNamed("numbers-guide-#{@page}.png")
    image = SKSpriteNode.spriteNodeWithTexture(texture)
    image.position = CGPointMake(mid_x, mid_y)
    image.name = "guideimage"
    image.size = CGSizeMake(max_x, max_y)
    addChild image
  end

  def remove_guide_image
    image = childNodeWithName('guideimage')
    removeChild image
  end

  def touchesBegan(touches, withEvent: event)
    if @page < 2
      @page += 1
      remove_guide_image
      add_guide_image
    else
      scene = MenuScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    end
  end
end
