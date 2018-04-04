import SpriteKit
import UIKit

open class View: SKView {
    
    public init() {
        let size = CGSize(width: 512, height: 512)
        super.init(frame: CGRect(origin: .zero, size: size))
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    open func setup() {
        
//        showsFPS = true
//        showsNodeCount = true
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if let scene = self.scene as? Scene {
            scene.size = frame.size
            scene.sizeDidChange()
        }
    }
}

