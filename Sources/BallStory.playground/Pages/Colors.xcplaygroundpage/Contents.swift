//#-hidden-code
import SpriteKit
import PlaygroundSupport

let view = GameView()
let scene = view.scene! as! GameScene
let size = scene.size

scene.playsOnTouch = true
scene.addButton.isHidden = true
scene.playButton.isHidden = true

scene.walls.removeFromParent()

let ball = scene.ball!
ball.position = CGPoint(x: 0, y: size.height * 0.35)

let paint = ButtonPaint()
paint.position = CGPoint(x: 0, y: -size.height * 0.3)
paint.zRotation = 0.005
scene.addChild(paint)

let label = SKLabelNode(text: "Hello!")
label.zPosition = -1
label.fontName = "HelveticaNeue"
label.fontSize = 90
label.fontColor = .white
label.fontColor = UIColor(red: 35 / 255.0, green: 38 / 255.0, blue: 41 / 255.0, alpha: 1)
scene.addChild(label)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view
//#-end-hidden-code

/*:
 # Splash Canvas
 
 WOW! It's certainly grateful for the new #D0E22C color, I mean... lime green! What about this waist? Any baseball ball would be jealousy.
 
 Hey, WAIT! This background does not combine with it's happyness. So then, the non-gray-anymore ball started to throw ink around.
 
 - Experiment: Touch the ball again
*/

