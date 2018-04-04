import SpriteKit

class Menu: SKNode {
    
    var visible = false
    var overlay: MenuOverlay!
    var contentNode: SKShapeNode!
    
    var contentSize: CGSize {
        return CGSize(width: 460, height: 460)
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {

        overlay = MenuOverlay()
        addChild(overlay)
        
        contentNode = SKShapeNode()
        contentNode.strokeColor = .clear
        contentNode.fillColor = .white
        contentNode.zPosition = 510
        contentNode.alpha = 0
        contentNode.setScale(0.8)
        contentNode.path = CGPath(roundedRect: CGRect.zero.insetBy(dx: -contentSize.width * 0.5, dy: -contentSize.height * 0.5), cornerWidth: 12, cornerHeight: 12, transform: nil)
        addChild(contentNode)
        
        isUserInteractionEnabled = true
    }
    
    func toggle() {
        
        if visible {
            hide()
        } else {
            show()
        }
    }
    
    func show() {
        
        guard !visible else { return }
        visible = true
        
        if let node = contentNode {
            
            let action = SKAction.group([
                SKAction.fadeAlpha(to: 1, duration: 0.25),
                SKAction.scale(to: 1, duration: 0.25)
            ])
            
            action.timingMode = .easeOut
            node.run(action)
        }
        
        overlay.show()
    }
    
    func hide() {
        
        guard visible else { return }
        visible = false
        
        if let node = contentNode {
            
            let action = SKAction.group([
                SKAction.fadeAlpha(to: 0, duration: 0.3),
                SKAction.scale(to: 0.8, duration: 0.3)
            ])
            
            action.timingMode = .easeIn
            node.run(action)
        }
        
        overlay.hide()
    }
}
