import SpriteKit

public class ButtonEmergency: Button {
    
    override var iconName: String {
        return "danger"
    }
    
    override func setup() {
        super.setup()
        
        once = true
    }
    
    override func onTrigger() {
        super.onTrigger()
        
        let prepare = SKAction.repeat(SKAction.sequence([
            SKAction.wait(forDuration: 0.25),
            SKAction.run { self.paint() },
            SKAction.scale(to: 1.3, duration: 0.05),
            SKAction.scale(to: 1, duration: 0.2),
        ]), count: 4)
        
        let actions = SKAction.sequence([
            prepare,
            SKAction.run { self.destroy() }
        ])
        
        run(actions)
    }
    
    func destroy() {
        
        let impulse = CGVector(dx: 0, dy: 16)
        
        if let scene = self.scene as? GameScene {
            for case let obstacle as Obstacle in scene.children {
                obstacle.physicsBody!.isDynamic = true
                obstacle.physicsBody!.applyImpulse(impulse)
            }
        }
        
        let action = SKAction.playSoundFileNamed("emergency-destroy", waitForCompletion: false)
        run(action)
        
        alpha = 0
    }
    
    func paint() {
        
        let action = SKAction.playSoundFileNamed("emergency-prepare", waitForCompletion: false)
        run(action)
        
        let count = Int.random(from: 10, to: 15)
        let deltaAngle = (2 * .pi) / CGFloat(count)
        
        for i in 0 ..< count {
            
            let angle = deltaAngle * CGFloat(i)
            let actions = SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(CGFloat.random01 * 0.2)),
                SKAction.run { self.canvas.paint(at: self.position, color: self.color, brush: .brushstroke, rotation: angle, scale: 0.7, anchor: .bottomAnchor, z: .random01) }
            ])
            
            run(actions)
        }
    }
    
    override func reset() {
        super.reset()
        
        alpha = 1
    }
}
