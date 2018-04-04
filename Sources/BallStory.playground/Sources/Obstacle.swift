import SpriteKit

public class Obstacle: WorldNode {
    
    var canActivate = false
    
    var gameScene: GameScene! {
        return scene as? GameScene
    }
    
    var canvas: Canvas {
        return gameScene.canvas
    }
    
    override func didTouch() {
        super.didTouch()
        
        if canActivate {
            activate()
        }
    }
    
    func activate() {
        
    }
    
    override func reset() {
        super.reset()
        
        removeAllActions()
    }
}
