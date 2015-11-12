class GameScene < BaseScene
  Number = Struct.new(:value, :position)

  def didMoveToView(view)
    super

    init_grid
    puts @numbers
  end

  def init_grid
    @numbers = []
    num_blocks = self.view.difficulty + 2
    (0..31).to_a.sample(num_blocks).each_with_index do |position, number|
      @numbers << Number.new(number+1, position)
    end
  end
end
