class BaseSKView < SKView
  attr_accessor :difficulty, :high_score, :score

  def update_high_score(new_score)
    @high_score = [@high_score, new_score].max
    @defaults = NSUserDefaults.standardUserDefaults
    @defaults['high'] = @high_score
    @defaults['level'] = self.difficulty
  end
end
