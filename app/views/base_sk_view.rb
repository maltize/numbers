class BaseSKView < SKView
  attr_accessor :difficulty, :high_score, :score

  def update_high_score(new_score)
    @high_score = [@high_score, new_score].max
  end
end
