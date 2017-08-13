//
//  BookListViewControllerTests.swift
//  BookExplorer
//
//  Created by Bharat Bhushan on 13/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import XCTest
import UIKit
@testable import BookExplorer

class BookListViewControllerTests: XCTestCase {
    
    var bookListViewController: BookListViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let bookListVC = storyBoard.instantiateViewController(withIdentifier: "MainStoryBoardId") as? BookListViewController
        bookListViewController = bookListVC
        bookListViewController?.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.bookListViewController = nil
    }
    
    
    func testViewDidLoad() {
        XCTAssertNotNil(bookListViewController?.viewDidLoad())
    }
    
    func testNumberOfSections() {
        XCTAssert((bookListViewController?.responds(to: #selector(bookListViewController?.numberOfSections(in:))))!)
        
    }
    
    func testViewWillDisplayCell() {

        XCTAssert((bookListViewController?.responds(to: #selector(bookListViewController?.tableView(_:willDisplay:forRowAt:))))!)
    }
    
    func testCellforRowAtIndexPath() {
        XCTAssertNotNil(bookListViewController?.responds(to: #selector(bookListViewController?.tableView(_:cellForRowAt:))))
    }
    
    func testNumberOfRowsInSection() {
        XCTAssert((bookListViewController?.responds(to: #selector(bookListViewController?.tableView(_:numberOfRowsInSection:))))!)
    }

}

