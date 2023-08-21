//
//  MainViewController.swift
//  Rick&MortiApp
//
//  Created by Кирилл Зезюков on 20.08.2023.
//

import UIKit

final class MainViewController: UIViewController, UIGestureRecognizerDelegate{
   

    //MARK: -- Private Properties
    private var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        _flowLayout.itemSize = CGSize(width: 156, height: 202)
        _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        _flowLayout.minimumInteritemSpacing = 16
        _flowLayout.minimumLineSpacing = 16
        return _flowLayout
    }
    private lazy var collectionView = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
    private lazy var leftAlinedLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = .systemFont(ofSize: 28)
        label.textAlignment = .left
        label.textColor = .white
        return label
        
    }()
    private var model = MainModel()
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        return refresh
    }()
    
    //MARK: -- Life Cycles Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor(named: "backgroundColor")
            let leftBarItem = UIBarButtonItem(customView: leftAlinedLabel)
            navigationItem.leftBarButtonItem = leftBarItem
            setupUI()
            setupConstraints()
            collectionView.backgroundColor = UIColor(named: "backgroundColor")
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.isScrollEnabled = true
            collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
            refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
            self.collectionView.addSubview(refreshControl)
            model.loadPosts()
            reload()
        }
    
    @objc func refresh(_sender: AnyObject){
        self.model.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            if   !(isLoadedSucces){
                  //  self.errorStateView()
            }
            self.refreshControl.endRefreshing()
        }
        
    }
    func reload() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.collectionView.layoutIfNeeded()
            }
        }
    }
        
}


// MARK: -- UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as? MainCollectionViewCell
        if let cell = cell {
            cell.title = model.items[indexPath.row].name
            cell.image = model.items[indexPath.row].imageUrlInString
        }
        return cell ?? UICollectionViewCell()
        
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.item = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - SetupUI, SetupConstraints
extension MainViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
    private func setupConstraints() {
         
        collectionView.translatesAutoresizingMaskIntoConstraints = false
     
        
        // CollectionView
        NSLayoutConstraint.activate([
           
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 49),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
              ])
           
             
          }
      }
