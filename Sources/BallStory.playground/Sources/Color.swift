import SpriteKit

public class Color: NSObject {
    
    public var imageName: String!
    public var color: UIColor?
    
    public static let rainbow = Color(imageNamed: "rainbow", color: nil)
    public static let red: Color = Color(imageNamed: "red", color: .red)
    public static let orange: Color = Color(imageNamed: "orange", color: .orange)
    public static let yellow: Color = Color(imageNamed: "yellow", color: .yellow)
    public static let green: Color = Color(imageNamed: "green", color: .green)
    public static let blue: Color = Color(imageNamed: "blue", color: .blue)
    public static let purple: Color = Color(imageNamed: "purple", color: .purple)
    
    init(imageNamed imageName: String, color: UIColor?) {
        self.imageName = imageName
        self.color = color
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
