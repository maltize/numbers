class ScoreScene < BaseScene
  def didMoveToView(view)
    super

    view.update_high_score(self.view.score)
    add_scores_titles(view.score, view.high_score)
  end

  def add_scores_titles(your_score, high_score)
    your_score_label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    your_score_label.text = "Score: #{your_score}"
    your_score_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    your_score_label.position = CGPointMake((max_x / 6), (max_y / 12) * 10)
    addChild your_score_label

    high_score_label = SKLabelNode.labelNodeWithFontNamed('Gill Sans')
    high_score_label.text = "High Score: #{high_score}"
    high_score_label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft
    high_score_label.position = CGPointMake((max_x / 6), (max_y / 12) * 9)
    addChild high_score_label
  end
end
