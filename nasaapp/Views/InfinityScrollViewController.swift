import UIKit
import RxSwift

class InfinityScrollViewController: UIViewController {
    
    private var uiController: InfinityScrollView
    private let viewModel: InfinityScrollViewModel
    
    private let reuseIdentifier = "cell"
    
    internal let disposeBag = DisposeBag()
    
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
        setupTableView()
        setupBinds()
        viewModel.fetchObject(dateOffset: 0)
    }
    
    private func setupTableView() {
        uiController.tableView.dataSource = self
        uiController.tableView.delegate = self
        uiController.tableView.register(NasaItemCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupBinds() {
        self.viewModel
            .reload
            .drive(onNext: { [unowned self] in
                self.uiController.tableView.reloadData()
            }).disposed(by: self.disposeBag)
    }
    
}

extension InfinityScrollViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NasaItemCell
        if (indexPath.item < viewModel.items.count) {
            cell.populateWithObject(item: viewModel.items[indexPath.item])
        } else {
            cell.populateWithNoData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var statusHeight: CGFloat!
        if #available(iOS 13.0, *) {
            statusHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusHeight = UIApplication.shared.statusBarFrame.height
        }
        return view.bounds.height-statusHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /*let offset = viewModel.items.count-1
        if indexPath.item == offset {
            viewModel.fetchObject(dateOffset: indexPath.item)
        }*/
        print("IndexPath.item: \(indexPath.item) ViewModelCount: \(viewModel.items.count)")
    }
    
}
