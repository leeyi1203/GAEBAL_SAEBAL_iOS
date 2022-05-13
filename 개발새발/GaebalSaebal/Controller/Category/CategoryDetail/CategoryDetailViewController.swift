//
//  CategoryDetailViewController.swift
//  GaebalSaebal
//
//  Created by 이봄이 on 2022/05/14.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    var receiveCategoryTitle: String?

    @IBOutlet weak var CategoryDetailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegateDataSource()
        setUpNaviTitle()

    }
    
    private func setUpNaviTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        
    }

}

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryContentsCell", for: indexPath)
        return cell
    }
    
    func setUpDelegateDataSource() {
        self.CategoryDetailTableView.delegate = self
        self.CategoryDetailTableView.dataSource = self
    }
    
    
}
