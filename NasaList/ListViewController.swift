//
//  ListViewController.swift
//  NasaList
//
//  Created by Felipe Bastos on 19/11/20.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var page = 1
    var dateSubtraction = -1
    var loadingStarted: Bool? = false
    var paginating: Bool = false
    
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UIScrollView Delegate
    //-----------------------------------------------------------------------

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            page = page + 1
            self.getPostList()
        }
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UITableView Delegate
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cache.posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = Cache.posts[indexPath.row]
        
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
        
        self.view.setGradientBackgroundUpDown(bottomColor: Constants.Color.Purple, topColor: Constants.Color.LightPurple)

        tbPosts?.alpha = 0
        
        lblHeader?.layer.shadowColor = UIColor.black.cgColor
        lblHeader?.layer.shadowOffset = CGSize(width: 1, height: 1)
        lblHeader?.layer.shadowRadius = 4
        lblHeader?.layer.shadowOpacity = 0.3
        
        getPostList()
    }
    
    func getPostList() {
        
        if Cache.posts.count <= 11 * page {
            paginating = true
            
            if loadingStarted == false {
                Util.showHUD(in: self.view)
                self.loadingStarted = true
            }
            
            let dayComp = DateComponents(day: dateSubtraction)
            let date = dateFormatTime(date: Calendar.current.date(byAdding: dayComp, to: Date())!)
            
            self.getPost(date: date)
            dateSubtraction -= 1
            
            if Cache.posts.count == 10 * page {
                tbPosts?.reloadData()
                Util.hideHUD()
                self.loadingStarted = false
                
                UIView.animate(withDuration: 0.4) {
                    self.tbPosts?.alpha = 1
                }
            }
        }
    }
    
    func getPost(date: String) {
        
        RequestManager().loadData(date: date) { (success, object, message) in
            if success {
                if let post = object {
                    Cache.posts.append(post)
                    
                    if Cache.posts.count == self.page * 10 {
                        self.paginating = false
                    }
                    
                    if Cache.posts.count <= 10 * self.page {
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

