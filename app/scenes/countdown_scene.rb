class CountDownScene < BaseScene

  def didMoveToView(view)
    super
    @start_time = nil
    @countdown = 3
    add_level_label
    add_counter_label
  end

  def add_level_label
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = "Level #{self.view.difficulty}"
    label.fontSize *= 1.5
    label.position = CGPointMake(mid_x, (max_y / 4) * 3)
    label.name = "level_label"
    addChild label
  end

  def add_counter_label
    label = SKLabelNode.labelNodeWithFontNamed("Zapfino")
    label.text = @countdown.to_s
    label.position = CGPointMake(mid_x, (max_y / 8) * 3)
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

    counter_label = childNodeWithName('counting')
    counter_label.position = CGPointMake(mid_x, counter_label.position.y - 1)
  end

  def update_counter
    counter_label = childNodeWithName('counting')
    counter_label.text = @countdown.to_s
  end

end
