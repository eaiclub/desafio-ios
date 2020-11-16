//
//  ViewController.swift
//  Teste EAI
//
//  Created by Alexandre Furquim on 12/11/20.
//

import UIKit

protocol ViewControllerDelegate {
    
    func requestSuccess()
    func requestFailure()
}

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellPercentWidth: CGFloat = 0.9
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    var model = [PlanetaryModelResponse]()
    
    private var viewModel: ViewControllerViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Planetary Nasa"
                        
        setupUI()
        setupRequest()
        
    }
    
    func setupUI() {
        // Get the reference to the CenteredCollectionViewFlowLayout (REQURED)
        centeredCollectionViewFlowLayout = (collectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        
        // Modify the collectionView's decelerationRate (REQURED)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        // Make the example pretty ✨
        view.applyGradient()
        
        // Assign delegate and data source
        viewModel = ViewControllerViewModel(controllerDelegate: self, parentController: self)
        self.collectionView.delegate = self.viewModel
        self.collectionView.dataSource = self.viewModel
        
        // Configure the required item size (REQURED)
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: view.bounds.width * cellPercentWidth,
            height: view.bounds.height * cellPercentWidth * cellPercentWidth
        )
        
        // Configure the optional inter item spacing (OPTIONAL)
        centeredCollectionViewFlowLayout.minimumLineSpacing = 20
    }
    
    func setupRequest() {
        viewModel?.getPlanetary()
    }
    
}

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [
            UIColor.peach.cgColor,
            UIColor.orange.cgColor
        ]
        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    static var peach: UIColor {
        return  UIColor.black
    }
    
    static var orange: UIColor {
        return UIColor.gray
    }
}

extension ViewController: ViewControllerDelegate {
    
    public func requestSuccess() {
        collectionView.reloadData()
    }
    
    public func requestFailure() {
        collectionView.reloadData()
    }

}
