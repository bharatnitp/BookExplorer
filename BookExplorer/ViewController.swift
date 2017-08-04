//
//  ViewController.swift
//  BookExplorerDemoApp
//
//  Created by Bharat Bhushan on 31/07/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableCount = 10
    var bookModel = BookListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        registerTableViewCells()
        bookModel.getBookList {[weak self](success, error) in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func registerTableViewCells() {
        
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCellReuseId")
        tableView.register(UINib(nibName: "BookDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "BookDetailTableViewCellReuseId")
        tableView.register(UINib(nibName: "SpinnerTableViewCell", bundle: nil), forCellReuseIdentifier: "SpinnerTableViewCellReuseId")
        
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //return  bookModel.bookList.count
        return tableCount;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        
//        if (authorsText?.characters.count ?? 0) > 0 {
//            cell?.authorNamesTextLabel.text = "By: " + authorsText!
//        } else {
//            cell?.authorNamesTextLabel.text = "By: NA"
//        }
//        let narratorText = narrators?.reduce("", {(narratorsString, narattor) in ((narattor["name"] as? String) ?? ""  + narratorsString)})
//        if narratorText?.characters.count ?? 0 > 0 {
//            cell?.narratorNamesTextLabel.text = "With: " + narratorText!
//        } else {
//            cell?.narratorNamesTextLabel.text = "With: NA"
//        }
//        
//        DataModel.sharedInstance.getBookImage(url: imageURL) { (image) in
//            DispatchQueue.main.async {
//                cell?.bookImageView.loadHTMLString(image!, baseURL: nil)
//            }
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailTableViewCellReuseId", for: indexPath) as? BookDetailTableViewCell
        cell?.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableCount - 1 {
            self.showContentLoadingIndicator();
            self.fetchNextPageContent();
        }
    }
    
    func showContentLoadingIndicator() {
        let footerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 100.0))
        footerView.backgroundColor = UIColor.white
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = footerView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        footerView.addSubview(activityIndicator)
        
        tableView.tableFooterView = footerView
    }
    
    func fetchNextPageContent() {
         bookModel.getBookList {[weak self] (success, error) in
            if success {
                self?.tableCount += 10
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.tableCount += 10
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func hideContentLoadingIndicator() {
        tableView.tableFooterView = UIView();
    }
}
