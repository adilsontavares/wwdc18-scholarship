import SpriteKit

public class GrenadeFragment: SKSpriteNode {
    
    let radius: CGFloat = 4
    
    public init(color: SKColor) {
        
        let texture = SKTexture(imageNamed: "grenade-fragment")
        super.init(texture: texture, color: color, size: texture.size())
        
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        colorBlendFactor = 1
        
        let body = SKPhysicsBody(circleOfRadius: radius)
        body.restitution = 0.6
        body.friction = 0.6
        body.categoryBitMask = 1
        body.contactTestBitMask = 0
        physicsBody = body
    }
}
