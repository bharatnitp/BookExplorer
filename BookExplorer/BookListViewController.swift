//
//  ViewController.swift
//  BookExplorerDemoApp
//
//  Created by Bharat Bhushan on 31/07/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var bookModel = BookListModel()
    var isPagingEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCells()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        //check for network connectivity
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if appDelegate?.reachability?.currentReachabilityStatus != .notReachable {
            fetchNextPageContent()
        } else {
            presentAlert()
        }
        
    }
    
    private func registerTableViewCells() {
        
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCellReuseId")
        tableView.register(UINib(nibName: "BookDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "BookDetailTableViewCellReuseId")
        
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension BookListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  bookModel.bookList.count + 1
        //return tableCount + 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 200.0
        }
        
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        
        return 16.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCellReuseId", for: indexPath) as? HeaderTableViewCell
            //cell?.coverImageView.image = UIImage(named: "placeholder")
            cell?.coverImageView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
            cell?.titleTextLabel.text = "Amazing Books..."
            return cell!
        } else {
            let book = bookModel.bookList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailTableViewCellReuseId", for: indexPath) as? BookDetailTableViewCell
            cell?.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
            
            cell?.bookTitleTextLabel.text = book.bookTitle ?? ""
                
            if (book.authors?.characters.count ?? 0) > 0 {
                cell?.authorNamesTextLabel.text = "By: " + book.authors!
            } else {
                cell?.authorNamesTextLabel.text = "By: NA"
            }
        
            if (book.authors?.characters.count ?? 0) > 0 {
                cell?.narratorNamesTextLabel.text = "With: " + book.narrators!
            } else {
                cell?.narratorNamesTextLabel.text = "With: NA"
            }
            
            if let imageURL = book.coverImageURL {
                bookModel.getBookImage(url: imageURL) { (image) in
                    DispatchQueue.main.async {
                        cell?.bookImageView.loadHTMLString(image!, baseURL: nil)
                    }
                }
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == bookModel.bookList.count {
            self.showContentLoadingIndicator()
            isPagingEnabled = true
            self.fetchNextPageContent()
        }
    }
    
    //Show actvity indicator in footerView
    private func showContentLoadingIndicator() {
        let footerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 100.0))
        footerView.backgroundColor = UIColor.white
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = footerView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        footerView.addSubview(activityIndicator)
        
        tableView.tableFooterView = footerView
    }
    
    //Get the nextpage content from API call
    fileprivate func fetchNextPageContent() {
         bookModel.getBookList {[weak self] (success, error) in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    if (self?.isPagingEnabled)! {
                        self?.hideContentLoadingIndicator()
                    }
                }
            }
        }
    }
    
    //hide footerview containing activity indicator
    private func hideContentLoadingIndicator() {
        tableView.tableFooterView = UIView()
    }
}

extension BookListViewController {
    fileprivate func presentAlert() {
        let alert = UIAlertController(title: "Network Error!", message: "No network connection available...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
