import SpriteKit

public class GameView: View {
    
    public override func setup() {
        super.setup()
        
        let scene = GameScene(size: frame.size)
        scene.scaleMode = .aspectFill
        presentScene(scene)
    }
}

