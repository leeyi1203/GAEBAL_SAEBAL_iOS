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
//        setCollectionViewDelegateDataSource()
        configure()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.subviews.forEach{
            print($0)
            if ( $0 is UIImageView ) {
                $0.isHidden = false
            }
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - 글 작성 버튼 생성 및 크기, 위치 조정
    private let imageView = UIImageView(image: UIImage(named: "write"))
    
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSize: CGFloat = 60
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMargin: CGFloat = 0
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeight: CGFloat = 20
    }
    
    private func setupWriteButton() {
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        /// 코드로 제약사항 추가하므로 false로 지정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -Const.ImageBottomMargin),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
        navigationItem.largeTitleDisplayMode = .always
        
        //클릭이벤트
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapWriteButton(sender:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)

    }
    
    @objc func tapWriteButton(sender:UIGestureRecognizer){
            //클릭시 실행할 동작
          performSegue(withIdentifier: "showWirteView", sender: nil)
    }
    
    private func configure() {
        let collectionViewLayout = MyLayout()
        collectionViewLayout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collectionView.layer.borderWidth = 1
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        guard let nextViewController = segue.destination as? CategoryDetailViewController else {
////            return
////        }
//
//        if segue.identifier ==
//    }

}

extension ViewController: MyCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.item].contentHeightSize
    }
}

//MARK: - Category Collection View
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
        vc.modalPresentationStyle = .fullScreen
        self.navigationController!.pushViewController(vc, animated: false)
    }
}
