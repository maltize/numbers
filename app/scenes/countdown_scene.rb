class CountDownScene < BaseScene

  def didMoveToView(view)
    super
    @start_time = nil
    @countdown = 3
    counter_label
  end

  def counter_label
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = @countdown.to_s
    label.position = CGPointMake(mid_x, mid_y)
    label.fontSize *= 4
    label.name = "counting"
    addChild label
  end

  def update(current_time)
    @start_time = current_time if !@start_time
    if current_time - @start_time >= 1
      @countdown -= 1
      if @countdown == 0
        scene = GameScene.alloc.initWithSize(view.bounds.size)
        scene.scaleMode = SKSceneScaleModeAspectFill
        self.view.presentScene scene
      else
        update_counter
        @start_time = current_time
      end
    end
  end

  def update_counter
    counter_label = childNodeWithName('counting')
    counter_label.text = @countdown.to_s
  end

end
