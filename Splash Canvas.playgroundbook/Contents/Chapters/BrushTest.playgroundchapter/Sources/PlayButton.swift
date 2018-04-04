import SpriteKit

public class PlayButton: SKSpriteNode {
    
    enum State: String {
        case idle = "play-button"
        case playing = "stop-button"
        case stopped = "restart-button"
    }
    
    public override var isUserInteractionEnabled: Bool {
        didSet { alpha = isUserInteractionEnabled ? 1 : 0.4 }
    }
    
    var state: State = .idle
    
    public init() {
        let texture = SKTexture(imageNamed: "play-button")
        super.init(texture: texture, color: .white, size: texture.size())
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        
        zPosition = 50
        isUserInteractionEnabled = true
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = self.scene as? GameScene else { return }
        
        switch state {
        case .idle:
            state = .playing
            scene.play()
        case .playing:
            state = .stopped
            scene.pause()
        case .stopped:
            state = .idle
            scene.restart()
        }
        
        updateTexture()
    }
    
    func updateTexture() {
        
        let texture = SKTexture(imageNamed: state.rawValue)
        self.texture = texture
    }
}
