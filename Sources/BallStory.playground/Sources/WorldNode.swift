import SpriteKit

public class WorldNode: SKNode, Updatable {
    
    var originalPosition: CGPoint = .zero
    var originalRotation: CGFloat = 0
    var destroysOnRestart = false
    var canEdit = true
    
    public var predominantColor: Color! {
        didSet { colorDidUpdate() }
    }
    
    var wantsColor: Bool {
        return true
    }
    
    var color: UIColor {
        if let color = predominantColor.color { return color.variate(by: 0.25) }
        return UIColor(hue: .random01, saturation: 0.8, brightness: 0.8, alpha: 1)
    }
    
    var radius: CGFloat {
        return 50
    }
    
    var hasDirection: Bool {
        return true
    }
    
    var directionAngle: CGFloat {
        return 0
    }
    
    var shadows = [Shadow]()
    var directionIndicator: SKSpriteNode!
    
    var showsDirection: Bool = false {
        didSet { directionIndicator?.isHidden = !showsDirection }
    }
    
    static let dict = [
        "ball": Ball.self,
        "canon": Canon.self,
        "grenade": Grenade.self,
        "shelf": Shelf.self,
        "bumper": Bumper.self,
        "button-danger": ButtonEmergency.self,
        "button-paint": ButtonPaint.self,
        "button-rainfall": ButtonRainfall.self
    ]
    
    var onTouch: (() -> Void)?
    
    public override init() {
        super.init()
        
        setup()
        setupBody()
        
        predominantColor = Color.rainbow
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    class func create(_ id: String) -> WorldNode? {
        
        guard let obj = WorldNode.dict[id] else { return nil }
        
        let type = obj as NSObject.Type
        let obstacle = type.init() as? WorldNode
        
        return obstacle
    }
    
    func didTouch() {
        
        let actions = SKAction.sequence([
            SKAction.scale(to: 0.9, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.2)
        ])
        
        run(actions)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        didTouch()
        onTouch?()
    }
    
    func setup() {
        
        isUserInteractionEnabled = true
        
        if hasDirection {
            directionIndicator = SKSpriteNode(imageNamed: "angle-pointer")
            directionIndicator.anchorPoint = .leftAnchor
            directionIndicator.isHidden = true
            directionIndicator.zPosition = -1
            directionIndicator.zRotation = directionAngle
            addChild(directionIndicator)
        }
        
        addObserver(self, forKeyPath: #keyPath(WorldNode.parent), options: [.initial, .new, .old], context: nil)
    }
    
    func setupBody() {
        physicsBody?.collisionBitMask = 1
        physicsBody?.contactTestBitMask = 1
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(WorldNode.parent) && scene != nil {
            didMoveToScene()
        }
    }
    
    public func update(delta: CGFloat) {
        
        for shadow in shadows {
            shadow.update(delta: delta)
        }
    }
    
    func createShadow(_ imageName: String) {
        
        let shadow = Shadow(imageNamed: imageName, referenceNode: self)
        shadow.zPosition = -10
        shadow.position = CGPoint(x: 10, y: -7)
        
        shadows.append(shadow)
    }
    
    func didMoveToScene() {
        
        for shadow in shadows {
            scene!.addChild(shadow)
        }
    }
    
    func reset() {
        
        position = originalPosition
        zRotation = originalRotation
        
        setScale(1)
    }
    
    func backup() {
        
        originalPosition = position
        originalRotation = zRotation
    }
    
    func colorDidUpdate() {
        
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(WorldNode.parent))
    }
}
