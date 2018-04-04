import SpriteKit

func + (a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x + b.x, y: a.y + b.y)
}

func += (a: inout CGPoint, b: CGPoint) {
    a = a + b
}

func - (a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x - b.x, y: a.y - b.y)
}

func * (a: CGPoint, x: CGFloat) -> CGPoint {
    return CGPoint(x: a.x * x, y: a.y * x)
}

prefix func - (a: CGPoint) -> CGPoint {
    return CGPoint(x: -a.x, y: -a.y)
}

extension CGPoint {
    
    static var one: CGPoint {
        return CGPoint(x: 1, y: 1)
    }
    
    var magnitude: CGFloat {
        let result = sqrt(x * x + y + y)
        if result.isNaN {
            return 0
        } else {
            return result
        }
    }
    
    var angle: CGFloat {
        return atan2(y, x)
    }
    
    static var bottomAnchor: CGPoint {
        return CGPoint(x: 0.5, y: 0)
    }
    
    static var topAnchor: CGPoint {
        return CGPoint(x: 0.5, y: 1)
    }
    
    static var leftAnchor: CGPoint {
        return CGPoint(x: 0, y: 0.5)
    }
    
    static var rightAnchor: CGPoint {
        return CGPoint(x: 1, y: 0.5)
    }
}
