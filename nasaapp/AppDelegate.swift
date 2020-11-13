import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let nasaService = NasaService()
        let nasaRepository = NasaRepository(with: nasaService)
        let viewModel = InfinityScrollViewModel(repository: nasaRepository, service: nasaService)
        let controller = InfinityScrollViewController(viewModel: viewModel)
        window.rootViewController = controller
        
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}

