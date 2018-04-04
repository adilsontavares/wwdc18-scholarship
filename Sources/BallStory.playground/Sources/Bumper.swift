import SpriteKit

public class Bumper: Obstacle {
    
    override var hasDirection: Bool {
        return false
    }
    
    override var radius: CGFloat {
        return 70
    }
    
    var body: SKSpriteNode!
    var ring: SKSpriteNode!
    
    override func setup() {
        super.setup()
        
        physicsBody = SKPhysicsBody(circleOfRadius: 28)
        physicsBody!.isDynamic = false
        
        body = SKSpriteNode(imageNamed: "bumper")
        body.zPosition = 1
        addChild(body)
        
        ring = SKSpriteNode(imageNamed: "bumper-ring")
        addChild(ring)
        
        createShadow("bumper-shadow")
    }
    
    override func activate() {
        super.activate()
        
        let bodyActions = SKAction.sequence([
            SKAction.wait(forDuration: 0.07),
            SKAction.scale(to: 1.1, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.05)
        ])
        
        let ringActions = SKAction.sequence([
            SKAction.scale(to: 0.8, duration: 0.1),
            SKAction.scale(to: 1.05, duration: 0.1),
            SKAction.run { self.fire() },
            SKAction.scale(to: 1, duration: 0.05)
        ])
        
        body.run(bodyActions)
        ring.run(ringActions)
        
        Sound.play("bumper")
    }
    
    func fire() {
        canvas.paint(at: position, color: color, brush: .standard, scale: 0.8, count: 2)
    }
    
    override func colorDidUpdate() {
        super.colorDidUpdate()
        
        ring.colorBlendFactor = 0.3
        ring.color = predominantColor.color ?? .white
    }
}
