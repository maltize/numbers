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
  end

  def init_grid
    @numbers = []
    num_blocks = self.view.difficulty + 2
    (0..31).to_a.sample(num_blocks).each_with_index do |position, number|
      @numbers << Number.new(number+1, position)
    end
  end

  def render_board
    @numbers.each { |number| render_number(number) }
  end

  def render_number(number)
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.fontSize *= 2
    label.text = "#{number.value}"
    label.position = CGPointMake(pos_x(number.position), pos_y(number.position))
    label.name = "#{number.value}"
    addChild label
  end

  def pos_x(pos)
    (0.5 + pos % 4) * (max_x / 4)  
  end
  
  def pos_y(pos)
    (0.25 + pos / 4) * (max_y / 8)
  end

  def update(current_time)
    @start_time = current_time if !@start_time
    if !@touch_enabled && current_time - @start_time >= @countdown
      @touch_enabled = true
      @numbers.each do |number|
        number_label = childNodeWithName(number.value.to_s)
        number_label.text = '*'
      end
    end
  end

  def touchesBegan(touches, withEvent: event)
    return if !@touch_enabled

    touch = touches.anyObject
    location = touch.locationInNode(self)
    node = nodeAtPoint(location)
    puts node.name

    number = @numbers.shift
    if number.value != node.name.to_i
      scene = ScoreScene.alloc.initWithSize(self.view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
      return
    end

    node.text = number.value.to_s

    self.view.score += self.view.difficulty * 10

    if @numbers.empty?
      self.view.difficulty += 1
      scene = CountDownScene.alloc.initWithSize(self.view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    end
  end
end
