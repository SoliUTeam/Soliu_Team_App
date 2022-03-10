import Foundation

enum Mood: Int {
    case great = 0
    case good = 1
    case pair = 2
    case poor = 3
    case bad = 4
    
    var text: String {
        switch self {
        case .great:
            return "Great"
        case .good:
            return "Good"
        case .pair:
            return "Pair"
        case .poor:
            return "Poor"
        case .bad:
            return "Bad"
        }
    }
}
