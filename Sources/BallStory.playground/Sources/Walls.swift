import SpriteKit

public class Walls: SKNode {
    
    let thickness: CGFloat = 30
    
    var size: CGSize {
        didSet { updateBody() }
    }
    
    public init(size: CGSize) {
        self.size = size
        super.init()
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        updateBody()
    }
    
    func updateBody() {
        
        let rect = CGRect.zero.insetBy(dx: -size.width * 0.5, dy: -size.height * 0.5)
        physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
        physicsBody!.isDynamic = false
    }
}
