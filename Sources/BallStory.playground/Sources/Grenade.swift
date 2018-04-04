import SpriteKit

public class Grenade: Obstacle {
    
    override var directionAngle: CGFloat {
        return .pi * 0.5
    }
    
    var body: SKSpriteNode!
    var canons = [SKNode]()
    
    let canonCount = 5
    
    override var hasDirection: Bool {
        return false
    }
    
    override var radius: CGFloat {
        return 70
    }
    
    override func setup() {
        super.setup()
        
        physicsBody = SKPhysicsBody(circleOfRadius: 29)
        physicsBody!.isDynamic = false
        
        body = SKSpriteNode(imageNamed: "grenade")
        body.zPosition = 1
        addChild(body)
        
        let deltaAngle = CGFloat.pi * 2 / CGFloat(canonCount)
        
        for i in 0 ..< 5 {
            
            let angle = deltaAngle * CGFloat(2 - i) + .pi * 0.5
            createCanon(at: angle)
        }
        
        createShadow("grenade-shadow")
    }
    
    private func createCanon(at angle: CGFloat) {
        
        let canon = SKSpriteNode(imageNamed: "grenade-canon")
        canon.position = CGPoint(x: 0, y: -16)
        canon.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        let node = SKNode()
        node.zRotation = angle + .pi * 0.5
        node.addChild(canon)
        
        addChild(node)
        canons.append(node)
    }
    
    private func prepareForFire() {
        
        let action = SKAction.scale(to: 0.85, duration: 0.3)
        
        for canon in canons {
            canon.run(action)
        }
    }
    
    override func activate() {
        super.activate()
        
        prepareForFire()
        fire(after: 1)
        
        Sound.play("grenade-prepare")
    }
    
    func fire(after delay: TimeInterval) {
        
        let actions = SKAction.sequence([
            SKAction.wait(forDuration: delay),
            SKAction.run { self.fire() }
        ])
        
        run(actions)
    }
    
    func fire() {
        
        for (index, canon) in canons.enumerated() {
            
            let delay = TimeInterval(index) * 0.2
            let actions = SKAction.sequence([
                SKAction.wait(forDuration: delay),
                SKAction.scale(to: 1.1, duration: 0.2),
                SKAction.run { self.shoot(at: canon.zRotation - .pi * 0.5) },
                SKAction.scale(to: 1, duration: 0.3)
            ])
            
            canon.run(actions)
        }
        
        let actions = SKAction.sequence([
            SKAction.wait(forDuration: 0.05),
            SKAction.scale(to: 0.96, duration: 0.05),
            SKAction.scale(to: 1.08, duration: 0.05),
            SKAction.scale(to: 1, duration: 0.05)
        ])
        
        run(SKAction.repeat(actions, count: canonCount))
    }
    
    override func reset() {
        super.reset()
        
        for canon in canons {
            canon.removeAllActions()
            canon.setScale(1)
        }
    }
    
    func shoot(at angle: CGFloat) {
        
        Sound.play("grenade-launch")
        
//        let radius: CGFloat = 30
        let normal = CGPoint(x: cos(angle), y: sin(angle))
        
//        let frag = GrenadeFragment(color: .red)
//        frag.position = normal * radius
//        frag.zRotation = angle
//        scene!.addChild(frag)
//
//        let force: CGFloat = 1
//        let impulse = CGVector(dx: cos(angle) * force, dy: sin(angle) * force)
//        frag.physicsBody!.applyImpulse(impulse)
        
        canvas.paint(at: position + normal * 20, color: color, brush: .splash, rotation: angle, scale: 0.6, anchor: .bottomAnchor, count: 3)
    }
    
    override func colorDidUpdate() {
        super.colorDidUpdate()
        
        for canon in canons {
            
            let node = canon.children.first! as! SKSpriteNode
            node.colorBlendFactor = 0.3
            node.color = predominantColor.color ?? .white
        }
    }
}
