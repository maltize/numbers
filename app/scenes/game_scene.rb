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
    (0.5 + pos % 4) * (max_x / 4) + Random.new.rand(-10..10)
  end
  
  def pos_y(pos)
    (0.25 + pos / 4) * (max_y / 8) + Random.new.rand(-10..10)
  end

  def add_star(position, name)
    texture = SKTexture.textureWithImageNamed("numbers-star.png")

    star = SKSpriteNode.spriteNodeWithTexture(texture)
    star.position = position
    star.name = name
    star.size = CGSizeMake(65, 65)
    star.anchorPoint = CGPointMake(0.5, 0.1)

    addChild star
  end

  def add_number(position, name)
    label = SKLabelNode.labelNodeWithFontNamed("Gill Sans")
    label.fontSize *= 2
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
      go_to_score_scene
      return
    end

    removeChild(node)
    add_number(node.position, node.name)

    self.view.score += self.view.difficulty * 10

    if @numbers.empty?
      self.view.difficulty += 1
      if self.view.difficulty >= 30
        go_to_score_scene
      else
        scene = CountDownScene.alloc.initWithSize(self.view.bounds.size)
        scene.scaleMode = SKSceneScaleModeAspectFill
        self.view.presentScene scene
      end
    end
  end

  def go_to_score_scene
    scene = ScoreScene.alloc.initWithSize(self.view.bounds.size)
    scene.scaleMode = SKSceneScaleModeAspectFill
    self.view.presentScene scene
  end
end
