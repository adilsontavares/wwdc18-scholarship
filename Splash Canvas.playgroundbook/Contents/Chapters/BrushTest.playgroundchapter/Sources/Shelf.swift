import SpriteKit

public class Shelf: Obstacle {
    
    var from: CGPoint = CGPoint(x: -35, y: 0) {
        didSet { updatePath() }
    }
    
    var to: CGPoint = CGPoint(x: 35, y: 0) {
        didSet { updatePath() }
    }
    
    override var wantsColor: Bool {
        return false
    }
    
    var body: SKShapeNode!
    
    override var directionAngle: CGFloat {
        return .pi * 0.5
    }
    
    override func setup() {
        super.setup()
        
        body = SKShapeNode()
        body.fillColor = .clear
        body.strokeColor = .white
        body.lineWidth = 14
        addChild(body)
        
        updatePath()
    }
    
    func updatePath() {
        
        zRotation = (to - from).angle
        position = (from + to) * 0.5
        
        let length = (to - from).magnitude
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: -length * 0.5, y: 0))
        path.addLine(to: CGPoint(x: length * 0.5, y: 0))
        
        body.path = path
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: length, height: body.lineWidth))
        physicsBody!.isDynamic = false
    }
}
