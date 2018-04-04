import SpriteKit

public class ButtonRainfall: Button {
    
    override var iconName: String {
        return "rainfall"
    }
    
    override func setup() {
        super.setup()
        
        once = true
    }
    
    override func onTrigger() {
        super.onTrigger()
        
        guard let scene = self.scene as? GameScene else { return }
        
        let count = 7
        let from: CGFloat = scene.size.width * -0.5 + 50
        let to = scene.size.width * 0.5 - 50
        let delta: CGFloat = (to - from) / CGFloat(count)
        
        for i in 0 ..< count {
            
            let ball = Ball()
            ball.destroysOnRestart = true
            ball.position = CGPoint(x: from + delta * CGFloat(i), y: scene.size.height * 0.5)
            scene.addChild(ball)
        }
    }
}

