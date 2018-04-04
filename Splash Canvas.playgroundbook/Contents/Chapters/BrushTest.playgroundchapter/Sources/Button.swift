import SpriteKit

public class Button: Obstacle {
    
    override var directionAngle: CGFloat {
        return .pi * 0.5
    }
    
    override var radius: CGFloat {
        return 60
    }
    
    override var wantsColor: Bool {
        return false
    }
    
    var trigger: SKSpriteNode!
    var icon: SKSpriteNode!
    var isToggle = true
    var once = false
    var triggerCount = 0
    
    var iconName: String {
        return "undefined"
    }
    
    private(set) var isOn = false
    
    override func setup() {
        super.setup()
        
        trigger = SKSpriteNode(imageNamed: "button-trigger")
        addChild(trigger)
        
        icon = SKSpriteNode(imageNamed: "button-\(iconName)")
        addChild(icon)
        
        let size = CGSize(width: 30, height: 30)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.isDynamic = false
        
        createShadow("button-shadow")
    }
    
    override func activate() {
        super.activate()
        push()
    }
    
    func push() {
        
        if once && triggerCount >= 1 {
            return
        }
        
        isOn = !isOn
        
        triggerCount += 1
        animateSprites()
        
        onTrigger()
    }
    
    func onTrigger() {
        Sound.play("button-click")
    }
    
    override func reset() {
        super.reset()
        
        trigger.setScale(1)
        icon.setScale(1)
        
        triggerCount = 0
        isOn = false
        
        animateSprites()
    }
    
    private func animateSprites() {
        
        let iconActions = SKAction.sequence([
            SKAction.wait(forDuration: 0.11),
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.2)
        ])
        
        icon.run(iconActions)
        
        if isToggle || once {
            trigger.run(SKAction.scale(to: isOn ? 0.4 : 1, duration: 0.2))
        } else {
            
            let triggerActions = SKAction.sequence([
                SKAction.scale(to: 0.6, duration: 0.1),
                SKAction.scale(to: 1, duration: 0.2)
            ])
            
            trigger.run(triggerActions)
        }
    }
}
