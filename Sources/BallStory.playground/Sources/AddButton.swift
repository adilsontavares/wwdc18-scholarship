import SpriteKit

public class AddButton: SKSpriteNode {
    
    public init() {
        let texture = SKTexture(imageNamed: "add-button")
        super.init(texture: texture, color: .white, size: texture.size())
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        
        zPosition = 50
        isUserInteractionEnabled = true
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let scene = self.scene as? GameScene {
            scene.createMenu.toggle()
        }
    }
}
