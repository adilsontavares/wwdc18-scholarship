//#-hidden-code
import UIKit
import CoreGraphics
import AVFoundation
import PlaygroundSupport
//#-end-hidden-code
//#-hidden-code
import SpriteKit
import PlaygroundSupport

let size = CGSize(width: 512, height: 512)
let view = GameView(frame: CGRect(origin: .zero, size: size))
let scene = view.scene! as! GameScene

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view
//#-end-hidden-code
/*:
 # Splash Canvas
 
 The gray also bothers you? The ball would be enthusiastic on your side. Maybe it would be a great ideia for you to make a mess together! But don't worry. I won't let anyone fight with you because a scratched wall this time...
 
 - Experiment: Create an incredible art
 1. Execute the code
 2. Add elements tapping the **+** button
 3. When ready, tap ▶️
 
 ---
 ### Play with Swift
 
 ```
 let canon = Canon()
 canon.predominantColor = .red
 scene.addObstacle(canon)
 ```
 
 You can create everything by code! There are many classes for your use:
 - Canon
 - Bumper
 - Grenade
 - Shelf
 - Ball
 - ButtonPaint
 - ButtonRainfall
 - ButtonEmergency
 
 What about colors?! Customize your obstacles to make it cool:
 - Rainbow (random colors)
 - Red
 - Orange
 - Yellow
 - Green
 - Blue
 - Purple
 
 Now... let's begin!
 Note: When creating elements by code, tap the ball to start.
 
 - Experiment: Create elements by code.
 */
