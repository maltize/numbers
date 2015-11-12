class BaseSKView < SKView
  attr_accessor :difficulty, :score, :high_score

  def update_high_score(new_score)
    @high_score = [@high_score, new_score].max
  end
end
