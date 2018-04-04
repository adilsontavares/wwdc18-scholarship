import SpriteKit

class Sound: SKNode {
    
    var sounds = [
        "emergency-prepare": 1,
        "emergency-explode": 1,
        "bumper": 7,
        "water": 5,
        "grenade-prepare": 1,
        "grenade-launch": 4,
        "canon": 1,
        "button-click": 3
    ]
    
    static var instance: Sound!
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func setup() {
        Sound.instance = self
    }
    
    static func play(_ soundName: String) {
        
        guard let count = instance.sounds[soundName] else { return }
        
        let name: String
        
        if count == 1 {
            name = soundName
        } else {
            let num = Int.random(from: 1, to: count)
            name = "\(soundName)\(num).wav"
        }
        
        let action = SKAction.playSoundFileNamed(name, waitForCompletion: false)
        Sound.instance.run(action)
    }
}
