//
//  ListViewController.swift
//  NasaList
//
//  Created by Felipe Bastos on 19/11/20.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var postArray: Array<Post> = []
    var page = 1
    var dateSubtraction = -1
    var loadingStarted: Bool? = false
    
    @IBOutlet var lblHeader: UILabel?
    @IBOutlet var tbPosts: UITableView?
    
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = postArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        cell?.loadUI(item: post)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {

        let hour = Calendar.current.component(.hour, from: Date())
        let minutes = Calendar.current.component(.minute, from: Date())
        
        if hour < 18 {
            self.view.setGradientBackgroundUpDown(bottomColor: Constants.Color.Orange, topColor: Constants.Color.Yellow)
        }else {
            self.view.setGradientBackgroundUpDown(bottomColor: Constants.Color.Purple, topColor: Constants.Color.LightPurple)
        }
        
        tbPosts?.alpha = 0
        
        lblHeader?.layer.shadowColor = UIColor.black.cgColor
        lblHeader?.layer.shadowOffset = CGSize(width: 1, height: 1)
        lblHeader?.layer.shadowRadius = 4
        lblHeader?.layer.shadowOpacity = 0.3
        
        getPostList()
    }
    
    func loadUI() {
        
    }
    
    func getPostList() {
        
        if postArray.count <= 10 * page {
            
            if loadingStarted == false {
                Util.showHUD(in: self.view)
                self.loadingStarted = true
            }
            
            let dayComp = DateComponents(day: dateSubtraction)
            let date = dateFormatTime(date: Calendar.current.date(byAdding: dayComp, to: Date())!)
            
            self.getPost(date: date)
            dateSubtraction -= 1
            
            if postArray.count == 10 * page {
                tbPosts?.reloadData()
                Util.hideHUD()
                
                UIView.animate(withDuration: 0.4) {
                    self.tbPosts?.alpha = 1
                }
                
                self.loadingStarted = false
            }
        }
    }
    
    func getPost(date: String) {
        
        
        RequestManager().loadData(date: date) { (success, object, message) in
            if success {
                if let post = object {
                    self.postArray.append(post)
                    
                    if self.postArray.count <= 10 * self.page {
                        self.getPostList()
                    }
                }
            }
        }
    }
    
    func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

