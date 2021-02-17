//
//  PlanetsListView.swift
//  NASA
//
//  Created by Gustavo Rodrigues Leitão on 10/02/21.
//  Copyright © 2021 grleitao. All rights reserved.
//

import UIKit

protocol PlanetsListViewDelegate: class {
    func didSelectPlanetarium(planetarium: PlanetariumModel, view: PlanetsListView)
}

class PlanetsListView: UIView {
    
    @IBOutlet private weak var tableView: UITableView!
    
    open weak var delegate : PlanetsListViewDelegate?
    
    private var observable : NSKeyValueObservation? = nil
    
    private var myPlanetariumsItems : [PlanetariumModel] = []

    init() {
        super.init(frame: .zero)
        self.xib()
        self.prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareLayout()
    }
    
    open func set(_ items: [PlanetariumModel] = []) {
        self.myPlanetariumsItems = items
        self.tableView.reloadData()
    }
    
    private func prepareLayout() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(class: PlanetsListTableViewCell.self)
        
        self.observable = tableView.observe(\.contentSize, options: .new, changeHandler: { (tableView, value) in
            if let newValue = value.newValue {
                self.tableView.addHeightConstaintOrUpdate(constant: newValue.height)
            }
        })
    }
}

extension PlanetsListView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPlanetariumsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: PlanetsListTableViewCell.self, indexPath: indexPath)
        cell.set(myPlanetariumsItems[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectPlanetarium(planetarium: myPlanetariumsItems[indexPath.item], view: self)
    }
}
