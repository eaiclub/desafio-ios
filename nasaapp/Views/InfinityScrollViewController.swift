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
        viewModel.setupInitialDates()
        viewModel.fetchObject()
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
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! NasaItemCell
        cell.delegate = self
        if (indexPath.item < viewModel.items.count) {
            cell.populateWithObject(item: viewModel.items[indexPath.item])
        } else {
            cell.populateWithNoData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return uiController.getCellHeight()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.fetchObjectOnWillDisplay(indexPath: indexPath)
    }
    
}

extension InfinityScrollViewController: NasaItemCellDelegate {
    
    func showAlert(title: String, message: String) {
        presentAlert(title: title, message: message, buttonText: "Ok")
    }
    
}
