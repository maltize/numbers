class GameViewController < UIViewController
  def loadView
    view = BaseSKView.new
    view.showsFPS = true
    view.showsNodeCount = true
    view.showsDrawCount = true

    @defaults = NSUserDefaults.standardUserDefaults
    view.difficulty = 1
    view.score = 0
    view.high_score = @defaults['high'] || 0

    self.view = view
  end

  def prefersStatusBarHidden
    true
  end

  def viewWillLayoutSubviews
    super

    unless self.view.scene
      scene = MenuScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      view.presentScene scene
    end
  end
end
