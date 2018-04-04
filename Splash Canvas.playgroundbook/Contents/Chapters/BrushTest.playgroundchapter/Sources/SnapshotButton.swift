import SpriteKit

class SnapshotButton: SKSpriteNode {
    
    var whiteShape: SKShapeNode!
    
    init() {
        let texture = SKTexture(imageNamed: "take-snapshot")
        super.init(texture: texture, color: .white, size: texture.size())
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        
        whiteShape = SKShapeNode(path: CGPath(rect: CGRect.zero.insetBy(dx: -512, dy: -512), transform: nil))
        whiteShape.zPosition = 1000
        whiteShape.alpha = 0
        whiteShape.strokeColor = .clear
        whiteShape.fillColor = .white
        
        isUserInteractionEnabled = true
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = self.scene as? GameScene else { return }
        
        let image = scene.canvas.snapshot
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        let actions = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.7, duration: 0.1),
            SKAction.fadeAlpha(to: 0, duration: 0.2)
        ])
        
        if whiteShape.parent == nil {
            scene.addChild(whiteShape)
        }
        
        whiteShape.run(actions)
    }
}

