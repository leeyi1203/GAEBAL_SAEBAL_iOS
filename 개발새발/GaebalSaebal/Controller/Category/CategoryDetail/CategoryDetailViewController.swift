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
    var categoryIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegateDataSource()
        setUpNaviTitle()
//        print(categoryIndex)
        CategoryDetailTableView.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setUpNaviTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.topItem?.title = categoryArray1[categoryIndex]
        let buttonImg = UIImage(named: "write")
        let writeBtn = UIButton()
        writeBtn.setImage(buttonImg, for: .normal)
        let barbuttonItem = UIBarButtonItem(customView: writeBtn)
        barbuttonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barbuttonItem.customView?.heightAnchor.constraint(equalToConstant: 45).isActive = true
        barbuttonItem.customView?.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.navigationItem.rightBarButtonItem = barbuttonItem
    }
    
    
    
    func logWillDelete(deleteIndex:IndexPath) {
        let alert = UIAlertController(title: nil, message: "이 기록을 삭제하시겠습니까?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (_) in
//            let object = contentsArray[self.categoryIndex][deleteIndex.section]
            recordArray[self.categoryIndex].remove(at: deleteIndex.section)
            self.CategoryDetailTableView.deleteRows(at: [deleteIndex], with: .fade)
            }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

    }

}

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recordArray[categoryIndex].count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = recordArray[categoryIndex]
        print("\(index)")
        let body = index[indexPath.section].body
//        let date = index[indexPath.section]
        let tag = index[indexPath.section].tag
        let cell = self.CategoryDetailTableView.dequeueReusableCell(withIdentifier: "categoryContentsCell", for: indexPath) as! CategoryDetailTableViewCell
        cell.contentLabel.text = body
        cell.tagLabel.text = tag
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let delete = UIContextualAction(style: .normal, title: "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("delete!!")
                self.logWillDelete(deleteIndex: indexPath)
                success(true)
            })
        
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func setUpDelegateDataSource() {
        self.CategoryDetailTableView.delegate = self
        self.CategoryDetailTableView.dataSource = self
    }
    
    
}
