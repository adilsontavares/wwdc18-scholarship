import SpriteKit

class MenuOverlay: SKShapeNode {
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        
        zPosition = 500
        alpha = 0
        strokeColor = .clear
        fillColor = UIColor.black.withAlphaComponent(0.65)
        path = CGPath(rect: CGRect.zero.insetBy(dx: -512, dy: -512), transform: nil)
        
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let menu = parent as? Menu {
            menu.hide()
        }
    }

    func show() {
        run(SKAction.fadeAlpha(to: 1, duration: 0.3))
    }
    
    func hide() {
        run(SKAction.fadeAlpha(to: 0, duration: 0.3))
    }
}

