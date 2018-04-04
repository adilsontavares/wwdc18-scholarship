import Foundation

extension Int {
    
    static func random(from: Int, to: Int) -> Int {
        return from + Int(arc4random()) % (to - from + 1)
    }
}
