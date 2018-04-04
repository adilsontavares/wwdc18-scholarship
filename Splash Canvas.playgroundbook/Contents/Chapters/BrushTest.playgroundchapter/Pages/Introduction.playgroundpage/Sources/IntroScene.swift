import SpriteKit

public class IntroScene: Scene {
    
    var neutralBall: SKSpriteNode!
    var ball: SKSpriteNode!
    var spotlightRight: SKSpriteNode!
    var spotlightLeft: SKSpriteNode!
    var lightLeft: SKSpriteNode!
    var lightRight: SKSpriteNode!
    var flagsRight: SKSpriteNode!
    var flagsLeft: SKSpriteNode!
    
    public override func setup() {
        super.setup()
        
        neutralBall = SKSpriteNode(imageNamed: "neutral-ball")
        neutralBall.alpha = 0
        neutralBall.setScale(0.4)
        addChild(neutralBall)
        
        ball = SKSpriteNode(imageNamed: "ball")
        ball.alpha = 0
        ball.setScale(0.7)
        addChild(ball)
        
        lightLeft = SKSpriteNode(imageNamed: "spotlight-light-left")
        lightLeft.anchorPoint = .zero
        lightLeft.zPosition = -1
        
        lightRight = SKSpriteNode(imageNamed: "spotlight-light-right")
        lightRight.anchorPoint = CGPoint(x: 1, y: 0)
        lightRight.zPosition = -1
        
        spotlightLeft = SKSpriteNode(imageNamed: "spotlight-left")
        spotlightLeft.alpha = 0
        spotlightLeft.anchorPoint = .zero
        spotlightLeft.setScale(0.9)
        spotlightLeft.addChild(lightLeft)
        addChild(spotlightLeft)
        
        spotlightRight = SKSpriteNode(imageNamed: "spotlight-right")
        spotlightRight.alpha = 0
        spotlightRight.anchorPoint = CGPoint(x: 1, y: 0)
        spotlightRight.setScale(0.9)
        spotlightRight.addChild(lightRight)
        addChild(spotlightRight)
        
        flagsRight = SKSpriteNode(imageNamed: "flags-right")
        flagsRight.alpha = 0
        flagsRight.zPosition = 1
        flagsRight.anchorPoint = CGPoint(x: 1, y: 1)
        addChild(flagsRight)
        
        flagsLeft = SKSpriteNode(imageNamed: "flags-left")
        flagsLeft.alpha = 0
        flagsLeft.zPosition = 1
        flagsLeft.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(flagsLeft)
        
        sizeDidChange()
        
        showNeutralBall(after: 1)
    }
    
    func showNeutralBall(after delay: TimeInterval) {
        
        let scale = SKAction.sequence([
            SKAction.scale(to: 1.1, duration: 0.1),
            SKAction.scale(to: 0.9, duration: 0.15),
            SKAction.scale(to: 1.0, duration: 0.2)
        ])
        
        let actions = SKAction.sequence([
            SKAction.wait(forDuration: delay),
            SKAction.group([
                scale,
                SKAction.fadeAlpha(to: 1, duration: 0.2)
            ])
        ])
        
        neutralBall.run(actions)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let point = touch.location(in: neutralBall)
        
        if neutralBall.contains(point) {
            showBall()
        }
    }
    
    func showBall() {
        
        let ballActions = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 0.3),
            SKAction.scale(to: 1, duration: 0.3),
            SKAction.playSoundFileNamed("presentation", waitForCompletion: false)
        ])
        
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.45)
        scaleUp.timingMode = .easeInEaseOut
        
        let scaleDown = SKAction.scale(to: 0.9, duration: 0.6)
        scaleDown.timingMode = .easeInEaseOut
        
        let live = SKAction.repeatForever(SKAction.sequence([
            scaleUp,
            scaleDown
        ]))
        
        ball.run(SKAction.sequence([
            ballActions,
            live
        ]))
        
        let neutralActions = SKAction.group([
            SKAction.scale(to: 0.7, duration: 0.3),
            SKAction.fadeAlpha(to: 0, duration: 0.3)
        ])
        
        neutralBall.run(neutralActions)
        
        let actions = SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.run { self.showLights() },
            SKAction.run { self.showFlags() },
        ])
        
        run(actions)
    }
    
    func showFlags() {
        
        let leftActions = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 0.7),
            SKAction.move(to: CGPoint(x: -size.width * 0.5, y: size.height * 0.5), duration: 0.7),
//            SKAction.playSoundFileNamed("flags1.wav", waitForCompletion: false)
        ])
        
        let rightActions = SKAction.group([
            SKAction.fadeAlpha(to: 1, duration: 1),
            SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height * 0.5), duration: 1),
//            SKAction.playSoundFileNamed("flags2.wav", waitForCompletion: false)
        ])
        
        leftActions.timingMode = .easeOut
        rightActions.timingMode = .easeOut
        
        flagsLeft.run(leftActions)
        flagsRight.run(rightActions)
    }
    
    func showLights() {
        
        let rightActions = SKAction.group([
            SKAction.scale(to: 1, duration: 0.3),
            SKAction.fadeAlpha(to: 1, duration: 0.2)
        ])
        
        spotlightRight.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.4),
            SKAction.playSoundFileNamed("spotlight1.wav", waitForCompletion: false),
            rightActions
        ]))
        
        let leftActions = SKAction.group([
            SKAction.scale(to: 1, duration: 0.2),
            SKAction.fadeAlpha(to: 1, duration: 0.2)
        ])
        
        spotlightLeft.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.playSoundFileNamed("spotlight2.wav", waitForCompletion: false),
            leftActions
        ]))
    }
    
    public override func sizeDidChange() {
        super.sizeDidChange()
        
        spotlightLeft.position = CGPoint(x: -size.width * 0.5, y: -size.height * 0.5)
        spotlightRight.position = CGPoint(x: size.width * 0.5, y: -size.height * 0.5)
        
        flagsRight.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5 + 100)
        flagsLeft.position = CGPoint(x: -size.width * 0.5, y: size.height * 0.5 + 150)
    }
}

