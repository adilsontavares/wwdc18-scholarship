import SpriteKit

public class Canon: Obstacle {
    
    var body: SKSpriteNode!
    var aim: SKSpriteNode!
    
    override var radius: CGFloat {
        return 70
    }
    
    override func setup() {
        super.setup()
        
        physicsBody = SKPhysicsBody(circleOfRadius: 29)
        physicsBody!.isDynamic = false
        
        body = SKSpriteNode(imageNamed: "canon-body")
        body.zRotation = .pi * -0.5
        addChild(body)
        
        aim = SKSpriteNode(imageNamed: "canon-aim")
        aim.anchorPoint = CGPoint(x: 0.5, y: 0)
        aim.position = CGPoint(x: 0, y: 10)
        aim.zPosition = -1
        body.addChild(aim)
        
        createShadow("canon-shadow")
    }
    
    override func activate() {
        super.activate()
        
        fire()
    }
    
    func fire() {
        
        let aimActions = SKAction.sequence([
            SKAction.move(to: CGPoint(x: 0, y: 6), duration: 0.05),
            SKAction.wait(forDuration: 0.05),
            SKAction.run { self.paint() },
            SKAction.group([
                SKAction.move(to: CGPoint(x: 0, y: 16), duration: 0.1),
                SKAction.scale(to: 1.1, duration: 0.1)
            ]),
            SKAction.group([
                SKAction.scale(to: 1, duration: 0.1),
                SKAction.move(to: CGPoint(x: 0, y: 14), duration: 0.1)
            ])
        ])
        
        let bodyActions = SKAction.sequence([
            SKAction.wait(forDuration: 0.05),
            SKAction.move(to: CGPoint(x: -8, y: 0), duration: 0.1),
            SKAction.move(to: .zero, duration: 0.2)
        ])
        
        aim.run(aimActions)
        body.run(bodyActions)
        
        Sound.play("canon")
    }
    
    func paint() {
        
        let angle = zRotation
        let radius: CGFloat = 20
        let offset = CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
        let color = self.color.variate(by: 0.1)
        let count = Int.random(from: 2, to: 3)
        
        canvas.paint(at: self.position + offset, color: color, brush: .splash, rotation: zRotation, scale: 0.7, anchor: CGPoint(x: 0.5, y: 0), count: count)
    }
    
    override func colorDidUpdate() {
        super.colorDidUpdate()
        
        aim.colorBlendFactor = 0.3
        aim.color = predominantColor.color ?? .white
    }
}

