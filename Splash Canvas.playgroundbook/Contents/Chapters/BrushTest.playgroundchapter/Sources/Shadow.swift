import SpriteKit

class Shadow: SKSpriteNode, Updatable {
    
    var referenceNode: SKNode!
    var offset = CGPoint(x: 10, y: -15)
    
    init(imageNamed imageName: String, referenceNode: SKNode) {
        
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .white, size: texture.size())
        
        self.referenceNode = referenceNode
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func update(delta: CGFloat) {
        
        alpha = referenceNode.alpha
        zRotation = referenceNode.zRotation
        position = referenceNode.position + offset
        
        if referenceNode.parent == nil {
            removeFromParent()
        }
    }
}
