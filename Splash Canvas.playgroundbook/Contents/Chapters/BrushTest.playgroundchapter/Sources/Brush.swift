import SpriteKit

public class Brush: SKSpriteNode {
    
    var isReady = false
    
    func animate() {
        
        let alpha = self.alpha
        let scale = self.xScale
        
        self.alpha = alpha - 0.15
        setScale(scale * 0.9)
        
        let duration = TimeInterval(CGFloat.random(from: 0.01, to: 0.04))
        
        let actions = SKAction.group([
            SKAction.scale(to: scale, duration: duration),
            SKAction.fadeAlpha(to: alpha, duration: duration)
        ])
        actions.timingMode = .easeOut
    
        run(SKAction.sequence([
            actions,
            SKAction.run { self.isReady = true }
        ]))
    }
}
