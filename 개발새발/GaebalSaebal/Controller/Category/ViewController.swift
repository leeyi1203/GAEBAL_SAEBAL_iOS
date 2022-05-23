//
//  CategoryCollectionViewCell.swift
//  GaebalSaebal
//
//  Created by 이봄이 on 2022/04/10.
//

import UIKit

class ViewController: UIViewController {
    
//    @IBOutlet weak var collectionView: UICollectionView!
    var collectionView: UICollectionView!
    var dataSource: [MyCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWriteButton()
        configure()
        setupDataSource()
        setupBackbutton()
    }
    
    //MARK: - 기록 작성 버튼
    func setupWriteButton() {
        navigationItem.largeTitleDisplayMode = .always
        let buttonImg = UIImage(named: "write")
        let writeBtn = UIButton()
        writeBtn.setImage(buttonImg, for: .normal)
        let barbuttonItem = UIBarButtonItem(customView: writeBtn)
        barbuttonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barbuttonItem.customView?.heightAnchor.constraint(equalToConstant: 45).isActive = true
        barbuttonItem.customView?.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.navigationItem.rightBarButtonItem = barbuttonItem
        
    }
    
    //MARK: - CollectionView 설정
    private func configure() {
        let collectionViewLayout = MyLayout()
        collectionViewLayout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collectionView.layer.borderWidth = 1
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 0, bottom: 10, right: 0)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.id)
    }
    
    private func setupDataSource() {
        dataSource = MyCategory.getMock()
//        print(dataSource)
    }
    
    private func setupBackbutton() {
        let backbutton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backbutton
    }


}

extension ViewController: MyCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.item].contentHeightSize
    }
}

//MARK: - Category Collection View data
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath) as! CategoryCollectionViewCell
        if let cell = cell as? CategoryCollectionViewCell {
            cell.myCategory = dataSource[indexPath.item]
            print("check")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryDetailView") as? CategoryDetailViewController else {
            return
        }
        vc.categoryIndex = indexPath.row
        vc.modalPresentationStyle = .fullScreen
        self.navigationController!.pushViewController(vc, animated: false)
    }
    
    
    
}
