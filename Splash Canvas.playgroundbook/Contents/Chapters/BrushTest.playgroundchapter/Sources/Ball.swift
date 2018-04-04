import SpriteKit

public class Ball: WorldNode {
    
    override var hasDirection: Bool {
        return false
    }
    
    override var wantsColor: Bool {
        return false
    }
    
    var body: SKSpriteNode!
    
    override func setup() {
        super.setup()
        
        body = SKSpriteNode(imageNamed: "ball")
        addChild(body)
     
        physicsBody = SKPhysicsBody(circleOfRadius: 16)
        physicsBody!.categoryBitMask = 1
        physicsBody!.restitution = 0.8
        
        createShadow("ball-shadow")
    }
    
    func hit(obstacle: Obstacle?) {
        Sound.play("water")
    }
}
