import UIKit

class InfinityScrollViewController: UIViewController {
    
    private var uiController: InfinityScrollView
    private let viewModel: InfinityScrollViewModel
    
    init(viewModel: InfinityScrollViewModel) {
        self.viewModel = viewModel
        uiController = InfinityScrollView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = uiController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
