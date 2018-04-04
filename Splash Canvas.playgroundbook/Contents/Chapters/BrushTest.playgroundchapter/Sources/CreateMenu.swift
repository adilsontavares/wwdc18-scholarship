import SpriteKit

class CreateMenu: Menu {
    
    override var contentSize: CGSize {
        return CGSize(width: 280, height: 500)
    }
    
    override func setup() {
        super.setup()
        
        let ids = [
            "canon",
            "bumper",
            "grenade",
            "shelf",
            "ball",
            "button-paint",
            "button-rainfall",
            "button-danger"
        ]
        
        let rows = 4
        let cols = 2
        let nodes = ids.map { WorldNode.create($0) }
        
        let delta: CGFloat = 120
        let origin = CGPoint(x: -delta * (CGFloat(cols) - 1) * 0.5, y: delta * CGFloat(rows - 1) * 0.5)
        
        var index = 0
        
        for i in 0 ..< rows {
            for j in 0 ..< cols {
        
                let node = nodes[index]!
                node.canEdit = false
                node.physicsBody = nil
                node.name = ids[index]
                node.canEdit = false
                (node as? Obstacle)?.canActivate = false
                node.onTouch = {
                    self.onSelectNode(node)
                }
                node.zPosition = contentNode.zPosition + 1
                node.physicsBody?.isDynamic = false
                node.position = origin + CGPoint(x: CGFloat(j) * delta, y: CGFloat(i) * -delta)
                contentNode.addChild(node)

                index += 1
            }
        }
        
        contentNode.fillColor = UIColor(hue: 208.0 / 360.0, saturation: 0.08, brightness: 0.15, alpha: 1)
    }
    
    func onSelectNode(_ node: WorldNode) {
        
        let actions = SKAction.sequence([
            SKAction.wait(forDuration: 0.15),
            SKAction.run { self.insertNode(withId: node.name!) }
        ])
        
        run(actions)
    }
    
    func insertNode(withId id: String) {
        
        guard let scene = self.scene as? GameScene else { return }
        
        let node = WorldNode.create(id)!
        node.physicsBody?.isDynamic = false
        
        if let obstacle = node as? Obstacle {
            obstacle.canActivate = false
            scene.addChild(obstacle)
        } else {
            scene.addChild(node)
        }
        
        scene.selectNode(node)
        
        hide()
    }
}
