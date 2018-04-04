import SpriteKit

public class GameScene: Scene, SKPhysicsContactDelegate {
    
    var canvas: Canvas!
    var oldTime: TimeInterval = 0
    
    public var ball: Ball?
    public var walls: Walls!
    public var playButton: PlayButton!
    public var addButton: AddButton!
    
    public var playsOnTouch = false {
        didSet {
            if playsOnTouch {
                selectNode(nil)
            }
        }
    }
    
    var sound: Sound!
    var snapshotButton: SnapshotButton!
    var createMenu: CreateMenu!
    var obstaclesButton: ObstaclesButton!
    var selectedNode: WorldNode?
    var colorPicker: ColorPicker!
    var isDraggingNode = false
    var isEditing = true
    
    var obstacles: [Obstacle] {
        return children.flatMap { $0 as? Obstacle }
    }
    
    var oldBallPosition: CGPoint = .zero
    var obstaclesParent: SKNode!
    var hideInterface = false {
        didSet { updateInterface() }
    }
    
    public override func setup() {
        super.setup()
        
        physicsWorld.contactDelegate = self
        
        sound = Sound()
        addChild(sound)
        
        obstaclesParent = SKNode()
        addChild(obstaclesParent)
        
        canvas = Canvas(size: view!.bounds.size)
        addChild(canvas)
        
        addButton = AddButton()
        addChild(addButton)
        
        playButton = PlayButton()
        addChild(playButton)
        
        createMenu = CreateMenu()
        addChild(createMenu)
        
        obstaclesButton = ObstaclesButton()
        obstaclesButton.anchorPoint = .topAnchor
        addChild(obstaclesButton)
        
        snapshotButton = SnapshotButton()
        snapshotButton.anchorPoint = .topAnchor
        addChild(snapshotButton)
        
        walls = Walls(size: size)
        addChild(walls)
        
        colorPicker = ColorPicker()
        colorPicker.zPosition = 10
        addChild(colorPicker)
        
        restart()
        
        ball = Ball()
        ball!.physicsBody!.isDynamic = false
        ball!.position = CGPoint(x: 1.5, y: size.height * 0.3)
        addChild(ball!)
        
        selectNode(ball)
    }
    
    public func addObstacle(_ node: WorldNode) {
        
        isEditing = false
        
        addButton.isHidden = true
        playButton.isHidden = true
        
        addChild(node)
        
        selectNode(node)
        selectNode(nil)
        
        playsOnTouch = true
    }
    
    public func selectNode(_ worldNode: WorldNode?) {
        
        if worldNode != nil && !worldNode!.canEdit {
            return
        }
        
        if let node = selectedNode {
            node.showsDirection = false
            node.isUserInteractionEnabled = false
            node.removeAction(forKey: "selected")
            node.setScale(1)
        }
        
        if !isEditing {
            return
        }
        
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.6)
        scaleUp.timingMode = .easeInEaseOut
        
        let scaleDown = SKAction.scale(to: 0.9, duration: 0.6)
        scaleDown.timingMode = .easeInEaseOut
        
        let actions = SKAction.repeatForever(SKAction.sequence([
            scaleUp,
            scaleDown
        ]))
        
        if let node = worldNode as? Obstacle, node.wantsColor {
            colorPicker.referenceNode = worldNode
        } else {
            colorPicker.referenceNode = nil
        }
        
        guard let node = worldNode else { return }
        
        node.showsDirection = true
        node.isUserInteractionEnabled = false
        
        if !node.wantsColor {
            node.run(actions, withKey: "selected")
        }
        
        selectedNode = node
    }
    
    public override func addChild(_ node: SKNode) {
        super.addChild(node)
        
        playButton?.isUserInteractionEnabled = !obstacles.isEmpty
    }
    
    func updateInterface() {
        
        let action = SKAction.fadeAlpha(to: hideInterface ? 0 : 1, duration: 0.12)
        
        for case let node as WorldNode in children {
            node.run(action)
        }
    }
    
    func handleContact(from bodyA: SKPhysicsBody, to bodyB: SKPhysicsBody) {
        
        guard let a = bodyA.node, let b = bodyB.node else {
            return
        }
        
        if let ball = bodyA.node as? Ball {
            let obstacle = bodyB.node as? Obstacle
            ball.hit(obstacle: obstacle)
        } else if let node = a as? Obstacle, b is Ball {
            node.activate()
        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
     
        handleContact(from: contact.bodyA, to: contact.bodyB)
        handleContact(from: contact.bodyB, to: contact.bodyA)
    }
    
    func play() {
        
        addButton.isHidden = true
        
        if !playsOnTouch {
            obstaclesButton.isHidden = false
            snapshotButton.isHidden = false
        }
        
        selectNode(nil)
        
        isEditing = false
        
        for case let node as WorldNode in children {
            node.backup()
        }
        
        for case let ball as Ball in children {
            ball.physicsBody!.isDynamic = true
        }
        
        physicsWorld.speed = 1
    }
    
    func pause() {
        
        physicsWorld.speed = 0
        
        for case let node as WorldNode in children {
            node.removeAllActions()
        }
    }
    
    func restart() {
        
        for case let node as WorldNode in children {
            node.reset()
            node.physicsBody!.isDynamic = false
        }
        
        addButton.isHidden = false
        
        canvas.clear()
        physicsWorld.speed = 1
        
        isEditing = true
        hideInterface = false
        
        obstaclesButton.isOn = true
        obstaclesButton.isHidden = true
        snapshotButton.isHidden = true
        
        for case let node as WorldNode in children {
            if node.destroysOnRestart {
                node.removeFromParent()
            }
        }
        
        playButton.isUserInteractionEnabled = !obstacles.isEmpty
        
        selectNode(nil)
    }
    
    public override func sizeDidChange() {
        super.sizeDidChange()
        
        let pos = CGPoint(x: size.width * 0.5 - 40, y: -size.height * 0.5 + 40)
        
        walls.size = size
        playButton.position = CGPoint(x: pos.x, y: 0)
        addButton.position = pos
        
        let headerPosition = CGPoint(x: 0, y: size.height * 0.5 - 20)
        let headerButtonOffset = CGPoint(x: 26, y: 0)
        
        obstaclesButton.position = headerPosition + headerButtonOffset
        snapshotButton.position = headerPosition - headerButtonOffset + CGPoint(x: 0, y: 7)
        
        canvas.size = size
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
        let delta = CGFloat(currentTime - oldTime)
        oldTime = currentTime
        
        for case let node as Updatable in children {
            node.update(delta: delta)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if playsOnTouch {
            play()
            playsOnTouch = false
            return
        }
        
        guard isEditing else { return }
        
        let touch = touches.first!
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location).flatMap { $0 as? WorldNode }
        
        if let node = nodes.first {
            selectNode(node)
            isDraggingNode = true
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard isEditing, let node = selectedNode else { return }
        
        let touch = touches.first!
        let position = touch.location(in: self)
        let offset = position - touch.previousLocation(in: self)
        let angle = (position - node.position).angle
        
        if isDraggingNode {
            node.position += offset
        } else if node.hasDirection {
            node.zRotation = angle - node.directionAngle
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDraggingNode = false
    }
}
