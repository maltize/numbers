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

    background_music
    unless self.view.scene
      scene = MenuScene.alloc.initWithSize(view.bounds.size)
      scene.scaleMode = SKSceneScaleModeAspectFill
      view.presentScene scene
    end
  end

  def background_music
    Dispatch::Queue.concurrent.async do
      mainBundle = NSBundle.mainBundle
      filePath = mainBundle.pathForResource("music", ofType:"mp3")
      fileData = NSData.dataWithContentsOfFile(filePath)
      error = Pointer.new(:object)

      @audio_player = AVAudioPlayer.alloc.initWithData(fileData, error:error)
      @audio_player.numberOfLoops = -1

      unless (@audio_player.nil?)
        @audio_player.delegate = self
        if (@audio_player.prepareToPlay && @audio_player.play)
          p "Successfully playing"
        else
          p "Failed to Play"
        end
      else
        p "Failed to instantiate AVAudioPlayer"
      end
    end
  end

end
