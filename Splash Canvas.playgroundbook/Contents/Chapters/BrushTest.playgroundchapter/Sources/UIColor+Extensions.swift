import SpriteKit

extension SKColor {
    
    func variate(by variation: CGFloat, includesAlpha: Bool = false) -> UIColor {
        
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bri: CGFloat = 0
        var alp: CGFloat = 0
        
        getHue(&hue, saturation: &sat, brightness: &bri, alpha: &alp)
        
        hue = CGFloat.lerp(from: hue - variation * 0.3, to: hue + variation * 0.3, time: .random01)
        sat = CGFloat.lerp(from: sat - variation, to: sat + variation, time: .random01)
        bri = CGFloat.lerp(from: bri - variation, to: bri + variation, time: .random01)
        
        if includesAlpha {
            alp = CGFloat.lerp(from: alp - variation, to: alp + variation, time: .random01)
        }
        
        hue = CGFloat.clamp(min: 0, max: 1, value: hue)
        sat = CGFloat.clamp(min: 0, max: 1, value: sat)
        bri = CGFloat.clamp(min: 0, max: 1, value: bri)
        alp = CGFloat.clamp(min: 0, max: 1, value: alp)
        
        return UIColor(hue: hue, saturation: sat, brightness: bri, alpha: alp)
    }
}
