import UIKit

// MARK: - FeatureFactory

protocol FeatureFactory {
    associatedtype Dependencies
    static func make(with dependencies: Dependencies) -> HomeViewModelProtocol
}
