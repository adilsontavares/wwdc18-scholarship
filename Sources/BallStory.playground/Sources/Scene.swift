import SpriteKit

open class Scene: SKScene {
    
    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        setup()
    }
    
    open func setup() {
        
        size = view!.frame.size
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    open func sizeDidChange() {
        
    }
}
