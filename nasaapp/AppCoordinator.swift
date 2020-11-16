import Foundation
import UIKit

class AppCoordinator {
    
    private var window: UIWindow
    private weak var appDelegate: AppDelegate?
    
    init(appDelegate: AppDelegate, window: UIWindow) {
        self.appDelegate = appDelegate
        self.window = window
    }
    
    func start() {
        let nasaService = NasaService()
        let nasaRepository = NasaRepository(with: nasaService)
        let viewModel = InfinityScrollViewModel(repository: nasaRepository, service: nasaService)
        let controller = InfinityScrollViewController(viewModel: viewModel)
        self.appDelegate?.window = self.window
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
}
