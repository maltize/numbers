class GameScene < BaseScene
  Number = Struct.new(:value, :position)

  def didMoveToView(view)
    super
    init_grid
    puts @numbers
    run_game
  end

  def init_grid
    @numbers = []
    num_blocks = self.view.difficulty + 2
    (0..31).to_a.sample(num_blocks).each_with_index do |position, number|
      @numbers << Number.new(number+1, position)
    end
  end

  def run_game
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

  def update(current_time)
    @delta = @last_update_time ? current_time - @last_update_time : 0
    @last_update_time = current_time
  end

  def pos_x(pos)
    (0.5 + pos % 4) * (max_x / 4)  
  end
  
  def pos_y(pos)
    (0.25 + pos / 4) * (max_y / 8)
  end

end
