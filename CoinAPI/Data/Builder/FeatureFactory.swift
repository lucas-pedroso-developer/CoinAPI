import UIKit

protocol FeatureFactory {
    associatedtype Dependencies
    static func make(with dependencies: Dependencies) -> HomeViewModelProtocol
}
