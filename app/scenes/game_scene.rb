class GameScene < BaseScene
  Number = Struct.new(:value, :position)

  def didMoveToView(view)
    super

    init_grid

  end

  def init_grid
    @numbers = []
    num_blocks = self.view.difficulty + 2
    (0..31).to_a.sample(num_blocks).each_with_index do |position, number|
      @numbers << Number.new(number+1, position)
    end
  end

  def touchesBegan(touches, withEvent: event)
    touch = touches.anyObject
    location = touch.locationInNode(self)
    node = nodeAtPoint(location)
    puts node.name

    if @numbers.shift.value.to_s != node.name
      scene = ScoreScene.alloc.initWithSize(self.view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    end

    self.view.score += self.view.difficulty * 10

    if @numbers.empty?
      self.view.difficulty += 1
      scene = GameScene.alloc.initWithSize(self.view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      self.view.presentScene scene
    end
  end
end
