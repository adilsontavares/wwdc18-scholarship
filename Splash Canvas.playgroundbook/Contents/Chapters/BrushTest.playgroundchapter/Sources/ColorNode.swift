import SpriteKit

class ColorNode: SKNode {

    var sprite: SKSpriteNode!
    var color: Color
    var onTouch: ((_ color: Color) -> Void)?
    
    var isSelected = false {
        didSet { updateAnimations() }
    }

    init(color: Color) {
        self.color = color
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        
        sprite = SKSpriteNode(imageNamed: "color-\(color.imageName!)")
        addChild(sprite)
        
        isUserInteractionEnabled = true
    }
    
    private func updateAnimations() {
        
        removeAction(forKey: "selected")
        alpha = isSelected ? 1 : 0.4
        setScale(1)
        
        if !isSelected {
            return
        }
        
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.6)
        scaleUp.timingMode = .easeInEaseOut
        
        let scaleDown = SKAction.scale(to: 0.95, duration: 0.6)
        scaleDown.timingMode = .easeInEaseOut
        
        let actions = SKAction.sequence([
            scaleUp,
            scaleDown
        ])
        
        run(SKAction.repeatForever(actions), withKey: "selected")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        onTouch?(color)
    }
}
