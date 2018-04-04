import SpriteKit

public extension CGFloat {
    
    public static var random01: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    public static var randomAngle: CGFloat {
        return random01 * 2 * .pi
    }
    
    public static func lerp(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat {
        return from + (to - from) * time
    }
    
    public static func clamp(min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
        return Swift.min(Swift.max(min, value), max)
    }
    
    public static func random(from: CGFloat, to: CGFloat) -> CGFloat {
        return lerp(from: from, to: to, time: .random01)
    }
}
