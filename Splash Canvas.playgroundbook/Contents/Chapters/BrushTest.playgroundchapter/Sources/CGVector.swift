import SpriteKit

extension CGVector {
    
    var angle: CGFloat {
        return atan2(dy, dx)
    }
}
