import SpriteKit

public enum BrushType: String {
    case splash = "splash"
    case brushstroke = "brushstroke"
    case standard = "brush"
}

public class Canvas: SKNode, Updatable {
    
    var size: CGSize
    var backgroundColorNode: SKSpriteNode!
    var backgroundNode: SKSpriteNode!
    var brushParent: SKNode!
    
    var snapshot: UIImage {
        
        let texture = scene!.view!.texture(from: self, crop: CGRect.zero.insetBy(dx: -size.width * 0.5, dy: -size.height * 0.5))
        return UIImage(cgImage: texture!.cgImage())
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
        
        brushParent = SKNode()
        addChild(brushParent)
        
        backgroundNode = SKSpriteNode()
        backgroundNode.name = "background"
        backgroundNode.zPosition = -100
        brushParent.addChild(backgroundNode)
        
        backgroundColorNode = SKSpriteNode(imageNamed: "background")
        backgroundColorNode.zPosition = -101
        backgroundColorNode.name = "background"
        brushParent.addChild(backgroundColorNode)
    }
    
    func clear() {
        
        capture()
        
        let texture = SKTexture(imageNamed: "background")
        backgroundNode.texture = texture
    }
    
    func paint(at location: CGPoint, color: UIColor, brush: BrushType = .standard, rotation: CGFloat = .randomAngle, scale: CGFloat = 1, anchor: CGPoint = .init(x: 0.5, y: 0.5), z: CGFloat = 0, count: Int = 1) {
        
        for _ in 0 ..< count {
            
            let num = Int.random(from: 1, to: 6)
            let node = Brush(imageNamed: "\(brush.rawValue)-\(num)")
            
            node.shader = backgroundNode.shader
            node.anchorPoint = anchor
            node.colorBlendFactor = 1
            node.color = count == 1 ? color : color.variate(by: 0.25)
            node.position = location
            node.zPosition = -99 + z
            node.zRotation = rotation - .pi * 0.5 + CGFloat.lerp(from: -0.15, to: 0.15, time: .random01)
            node.setScale(CGFloat.lerp(from: 0.7, to: 1, time: .random01) * scale)
            node.animate()
            
            brushParent.addChild(node)
        }
    }
    
    func update(delta: CGFloat) {
        capture()
    }
    
    func capture() {
        
        guard brushParent.children.count > 2 else { return }
        
        let brushes = brushParent.children.flatMap { $0 as? Brush }
        let readyNodes = brushes.filter { $0.isReady }
        let notReadyNodes = brushes.filter { !$0.isReady }
        
        for node in notReadyNodes {
            node.isHidden = true
        }
        
        for node in readyNodes {
            node.shader = nil
        }
        
        let shader = backgroundNode.shader
        backgroundNode.shader = nil
        
        let size = scene!.size
        let bounds = CGRect(x: -size.width * 0.5, y: -size.height * 0.5, width: size.width, height: size.height)
        let texture = scene!.view!.texture(from: brushParent, crop: bounds)
        
        backgroundNode.size = size
        backgroundNode.shader = shader
        backgroundNode.texture = texture
        
        for node in notReadyNodes {
            node.isHidden = false
        }
        
        for node in readyNodes {
            node.removeFromParent()
        }
    }
}

