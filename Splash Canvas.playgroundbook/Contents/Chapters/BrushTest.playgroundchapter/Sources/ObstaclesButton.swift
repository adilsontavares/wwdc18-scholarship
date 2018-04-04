import SpriteKit

class ObstaclesButton: SKSpriteNode {
    
    var isOn = true {
        didSet { updateTexture() }
    }
    
    init() {
        let texture = SKTexture(imageNamed: "obstacles-button-on")
        super.init(texture: texture, color: .white, size: texture.size())
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        isUserInteractionEnabled = true
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isOn = !isOn
        
        if let scene = self.scene as? GameScene {
            scene.hideInterface = !isOn
        }
    }
    
    func updateTexture() {
        
        let texture = SKTexture(imageNamed: "obstacles-button-\(isOn ? "on": "off")")
        self.texture = texture
    }
}
