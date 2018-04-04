import SpriteKit

public class ButtonPaint: Button {
    
    override var iconName: String {
        return "paint"
    }
    
    override var wantsColor: Bool {
        return true
    }
    
    override func setup() {
        super.setup()
        once = true
    }
    
    override func onTrigger() {
        super.onTrigger()
        
        let size = scene!.size
        let rows = 15
        let cols = 10
        
        let origin = CGPoint(x: -size.width * 0.5, y: -size.height * 0.5)
        let deltaX = size.width / CGFloat(cols - 1)
        let deltaY = size.height / CGFloat(rows - 1)
        
        for i in 0 ..< rows {
            for j in 0 ..< cols {
                
                let position = origin + CGPoint(x: deltaX * CGFloat(j), y: deltaY * CGFloat(i))
                let offset = CGPoint(x: CGFloat.lerp(from: -20, to: 20, time: .random01),
                                     y: CGFloat.lerp(from: -20, to: 20, time: .random01))
                
                let actions = SKAction.sequence([
                    SKAction.wait(forDuration: TimeInterval(CGFloat.random01 * 0.25)),
                    SKAction.run { self.canvas.paint(at: position + offset, color: self.color, brush: .splash, scale: 1, count: 1) }
                ])
                
                run(actions)
            }
        }
    }
}

