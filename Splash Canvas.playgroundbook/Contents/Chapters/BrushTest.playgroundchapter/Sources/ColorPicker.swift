import SpriteKit

class ColorPicker: SKNode, Updatable {
    
    var radius: CGFloat {
        return referenceNode?.radius ?? 0
    }
    
    var referenceNode: WorldNode? {
        didSet {
            referenceNodeDidUpdate()
        }
    }
    
    let colors = [
        Color.rainbow,
        Color.red,
        Color.orange,
        Color.yellow,
        Color.green,
        Color.blue,
        Color.purple
    ]
        
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        
        for color in colors {
            createColor(with: color)
        }
    }
    
    func createColor(with color: Color) {
        
        let node = ColorNode(color: color)
        node.onTouch = onTouchColor
        addChild(node)
    }
    
    func onTouchColor(_ color: Color) {
        select(color: color)
    }
    
    func select(color: Color) {
        
        for case let node as ColorNode in children {
            node.isSelected = node.color == color
        }
        
        if let node = referenceNode {
            node.predominantColor = color
        }
    }
    
    func update(delta: CGFloat) {
        
        isHidden = (referenceNode == nil)
        guard let node = referenceNode else { return }
        
        position = node.position + CGPoint(x: 0, y: -5)
    }
    
    func referenceNodeDidUpdate() {
        
        let delta: CGFloat = (2 * .pi) / CGFloat(colors.count)
        
        for (i, node) in children.enumerated() {
            
            let angle = delta * CGFloat(i) + .pi * 0.5
            let position = CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
            
            node.position = position
        }
        
        if let node = referenceNode as? Obstacle, node.wantsColor {
            select(color: node.predominantColor)
        }
    }
}

