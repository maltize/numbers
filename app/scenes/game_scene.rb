class GameScene < BaseScene
  Number = Struct.new(:value, :position)

  def didMoveToView(view)
    super

    @start_time = nil
    @countdown = 2
    @touch_enabled = false
    init_grid
    puts @numbers
    render_board
    add_timer_label
    add_pause_label
    @duration = 0
    @timer = nil
  end

  def init_grid
    @numbers = []
    num_blocks = self.view.difficulty + 2
    max_blocks = max_level + 2
    (0..(max_blocks - 1)).to_a.sample(num_blocks).each_with_index do |position, number|
      @numbers << Number.new(number+1, position)
    end
  end

  def render_board
    @numbers.each { |number| render_number(number) }
  end

  def render_number(number)
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.fontSize *= 2 * font_size_multiplier
    label.text = "#{number.value}"
    label.position = CGPointMake(pos_x(number.position), pos_y(number.position))
    label.name = "#{number.value}"
    addChild label
  end

  def pos_x(pos)
    (0.5 + pos % max_rows) * (max_x / max_rows) + Random.new.rand(-shake..shake)
  end
  
  def pos_y(pos)
    (0.25 + pos / max_rows) * (max_y / max_columns) + Random.new.rand(-shake..shake)
  end

  def add_star(position, name)
    texture = SKTexture.textureWithImageNamed("numbers-star.png")

    star = SKSpriteNode.spriteNodeWithTexture(texture)
    star.position = position
    star.name = name
    star.size = CGSizeMake(75 * font_size_multiplier, 75 * font_size_multiplier)
    star.anchorPoint = CGPointMake(0.5, 0.1)

    addChild star
  end

  def add_number(position, name)
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.fontSize *= 2 * font_size_multiplier
    label.text = name
    label.position = position
    label.name = name

    addChild label
  end

  def update(current_time)
    @start_time = current_time if !@start_time
    if !@touch_enabled && current_time - @start_time >= @countdown
      @touch_enabled = true
      @numbers.each do |number|
        number_label = childNodeWithName(number.value.to_s)
        removeChild(number_label)
        add_star(number_label.position, number_label.name)
      end
      @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerFired', userInfo:nil, repeats:true)
    end
  end

  def touchesBegan(touches, withEvent: event)
    touch = touches.anyObject
    location = touch.locationInNode(self)
    node = nodeAtPoint(location)
    puts node.name

    if node.name == 'pause'
      return unless @timer

      if self.isPaused
        remove_shadow
        self.paused = false
        @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerFired', userInfo:nil, repeats:true)
      else
        add_shadow
        self.paused = true
        @timer.invalidate
      end
    else
      number_tapped(node)
    end
  end

  def number_tapped(node)
    return if !@touch_enabled or self.isPaused

    number = @numbers.shift
    if number.value != node.name.to_i
      self.view.score += calculate_score
      go_to_score_scene
      return
    end

    removeChild(node)
    add_number(node.position, node.name)

    if @numbers.empty?
      self.view.score += calculate_score
      self.view.difficulty += 1
      if self.view.difficulty >= max_level
        go_to_score_scene
      else
        scene = CountDownScene.alloc.initWithSize(self.view.bounds.size)
        scene.scaleMode = SKSceneScaleModeAspectFill
        self.view.presentScene scene
      end
    end
  end

  def calculate_score
    num_blocks = self.view.difficulty + 2
    correct_blocks = num_blocks - @numbers.length
    score = correct_blocks * self.view.difficulty * 10
    puts "Score: #{score} | Time: #{@duration}"
    normalized_score = score * (1 - ([@duration, 30.0].min / 30.0 * 0.9))
    puts "Normalized : #{normalized_score.to_i}"
    normalized_score.to_i
  end

  def go_to_score_scene
    scene = ScoreScene.alloc.initWithSize(self.view.bounds.size)
    scene.scaleMode = SKSceneScaleModeAspectFill
    self.view.presentScene scene
  end

  def add_timer_label
    @timer_label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    @timer_label.position = CGPointMake(max_x / max_columns, max_y * (max_columns * 2 - 1) / (max_columns * 2))
    @timer_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    @timer_label.name = 'timer'
    @timer_label.fontSize *= font_size_multiplier
    addChild @timer_label
  end

  def add_pause_label
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.text = 'Pause'
    label.fontSize *= font_size_multiplier
    label.position = CGPointMake(max_x * (max_columns - 1) / max_columns, max_y * (max_columns * 2 - 1) / (max_columns * 2))
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight
    label.name = 'pause'
    label.zPosition = 40 # must be above shadow
    addChild label
  end

  def timerFired
    @timer_label.text = "%.1f" % (@duration += 0.1)
  end
end
