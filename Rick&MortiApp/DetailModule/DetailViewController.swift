//
//  DetailViewController.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import UIKit


class DetailViewController: UIViewController {
    
    
    
    //MARK: -- Private Properties
      private lazy var scrollView: UIScrollView = {
          let scrollView = UIScrollView(frame: .zero)
          scrollView.isUserInteractionEnabled = true
          scrollView.isScrollEnabled = true
          scrollView.showsVerticalScrollIndicator = false
          return scrollView
      }()
      
      private lazy var contentView: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .vertical
          stackView.spacing = 24
          stackView.alignment = .center
          stackView.backgroundColor = UIColor(named: "backgroundColor")
          return stackView
      }()

      //MARK: -- TitleBlock
    private lazy var titleBlockView: UIView = {
           let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
           return view
       }()
      private lazy var titleLabel: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.textColor = .white
          label.font = .systemFont(ofSize: 22)
          return label
      }()
    private lazy var charecterImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFit
           imageView.layer.cornerRadius = 16
           imageView.clipsToBounds = true
           return imageView
       }()
       
       private lazy var statusLabel: UILabel = {
           let label = UILabel()
           label.numberOfLines = 1
           label.textAlignment = .center
           label.textColor = UIColor(named: "greenTextColor")
           label.font = .systemFont(ofSize: 17)
           return label
       }()
       
       //MARK: -- InformationBlock
    private lazy var infoBlockView: UIView = {
           let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
           return view
       }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private lazy var infoTableView:  UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cellBackgroundColor")
        view.layer.cornerRadius = 16
        return view
    }()
    private lazy var infoTableViewCells: [InfoTableViewCell] = {
        var array: [InfoTableViewCell] = []
        for _ in 0..<3 {
            array.append(InfoTableViewCell())
        }
        return array
    }()
       //MARK: -- OriginBlock
       private lazy var locationImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(named: "Planet")
           imageView.contentMode = .scaleAspectFit
           imageView.tintColor = .white
           return imageView
       }()
    private lazy var locationBackgroundImageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.16, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
       private lazy var locationLabel: UILabel = {
           let label = UILabel()
           label.text = "Origin"
           label.textColor = .white
           label.font = .systemFont(ofSize: 17)
           return label
       }()
    private lazy var nameOfOrigin: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private lazy var typeOfOrigin: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "greenTextColor")
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    private var type: String = ""{
        didSet {
            typeOfOrigin.text = type
        }
    }
    
    private lazy var locationBlockView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    private lazy var locationView: UIView = {
           let view = UIView()
            view.backgroundColor = UIColor(named: "cellBackgroundColor")
        view.layer.cornerRadius = 16
           return view
       }()
       
      
      
       //MARK: -- EpisodesBlock
    private var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()

        _flowLayout.itemSize = CGSize(width: 327, height: 86)
        _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        _flowLayout.minimumInteritemSpacing = 16
        _flowLayout.minimumLineSpacing = 16
        
        return _flowLayout
    }
    private lazy var episodesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private lazy var episodesCollectionViewHeightConstraint: NSLayoutConstraint = {
            return episodesCollectionView.heightAnchor.constraint(equalToConstant: 102)
        }()
    private lazy var episodesBlockView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundColor")
        return view
    }()
    private lazy var episodesLabel: UILabel = {
        let label = UILabel()
        label.text = "Episodes"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    // MARK: - Properties
    var item: DetailItemModel = .createDefault()
    private var episodesArray: [EpisodeResponseModel] = []
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
               
        self.view.backgroundColor = UIColor(named: "backgroundColor")
               
        setupUI()
        setupConstraints()
        configure()
        episodesCollectionView.backgroundColor = UIColor(named: "backgroundColor")
        episodesCollectionView.dataSource = self
        episodesCollectionView.delegate = self
        episodesCollectionView.isScrollEnabled = false
        episodesCollectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier)
      
        
        episodesCollectionView.layoutIfNeeded()
        updateCollectionViewHeight()
    }
    

    

}

// MARK: -- UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier, for: indexPath) as? EpisodeCollectionViewCell
        if let cell = cell {
            cell.title = episodesArray[indexPath.row].name
            cell.dateCreation = episodesArray[indexPath.row].air_date
            cell.number = episodesArray[indexPath.row].episode
        }
        return cell ?? UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 327, height: 86)
        }
}


//MARK: -- Private Extension
private extension DetailViewController{
    func configure() {
        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        titleLabel.text = item.name
        if let url = URL(string: item.imageUrlInString) {
            charecterImageView.loadImage(from: url)
        }
        statusLabel.text = item.status
       
        infoTableViewCells[0].title = "Species:"
        infoTableViewCells[0].info = item.species
        infoTableViewCells[1].title = "Type:"
        infoTableViewCells[1].info = item.type
        infoTableViewCells[2].title = "Gender:"
        infoTableViewCells[2].info = item.gender
        
        nameOfOrigin.text = item.origin.name
       getTypeOrigin(url: item.origin.url) //TODO: getType
        
        for episode in item.episode {
            loadEpisode(urlString: episode)
        }
        
        
    }
    func updateCollectionViewHeight() {
            let contentHeight = item.episode.count * 102
            let minimumHeight: Int = 102
            let newHeight = max(contentHeight + 16, minimumHeight)
        episodesCollectionViewHeightConstraint.constant = CGFloat(newHeight)
            contentView.layoutIfNeeded()
        }
    
    //MARK: - URLSession Methods
    
    func loadEpisode(urlString: String) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                    if let data = data {
                        do {
                            let episode = try JSONDecoder().decode(EpisodeResponseModel.self, from: data)
                            episodesArray.append(episode)
                            
                            DispatchQueue.main.async {
                                self.episodesCollectionView.reloadData()
                            }
                        } catch {
                            print("Ошибка декодирования: \(error)")
                        }
                    }
                }
                task.resume()
            }
        }
    func getTypeOrigin(url: String) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("Data not found")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let typeOrigin = json["type"] as? String{
                        DispatchQueue.main.async {
                            self.type = typeOrigin
                        }
                        }
                    }
                }
            catch {
                print("Error while parsing JSON: \(error)")
            }
        }
        task.resume()

    }
    func reload() {
        episodesCollectionView.reloadData()
        episodesCollectionView.layoutIfNeeded()
        updateCollectionViewHeight()
    }
}

// MARK: - SetupUI, SetupConstraints
extension DetailViewController {
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //Blocks
        contentView.addSubview(titleBlockView)
        contentView.addSubview(infoBlockView)
        contentView.addSubview(locationBlockView)
        contentView.addSubview(episodesBlockView)
        
        //Title
        titleBlockView.addSubview(charecterImageView)
        titleBlockView.addSubview(titleLabel)
        titleBlockView.addSubview(statusLabel)
        
        //Info
        infoBlockView.addSubview(infoLabel)
        infoBlockView.addSubview(infoTableView)
        infoTableView.addSubview(infoTableViewCells[0])
        infoTableView.addSubview(infoTableViewCells[1])
        infoTableView.addSubview(infoTableViewCells[2])
      
        
        //Origin
        locationBlockView.addSubview(locationLabel)
        locationBlockView.addSubview(locationView)
        
        locationView.addSubview(locationBackgroundImageView)
        locationView.addSubview(nameOfOrigin)
        locationView.addSubview(typeOfOrigin)
        
        locationBackgroundImageView.addSubview(locationImageView)
        
        //Episodes
        episodesBlockView.addSubview(episodesLabel)
        //episodesBlockView.addSubview(episodesCollectionView)
        contentView.addSubview(episodesCollectionView)
    }
    private func setupConstraints() {
         
        
        
        //scrollView
        NSLayoutConstraint.activate([
                    scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        //contentView
        NSLayoutConstraint.activate([
                   contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                   contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                   contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                   contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                   contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
               ])
        //titleBlockView
        NSLayoutConstraint.activate([
            titleBlockView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleBlockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleBlockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleBlockView.heightAnchor.constraint(equalToConstant: 241)
               ])
        //infoBlockView
        NSLayoutConstraint.activate([
            infoBlockView.topAnchor.constraint(equalTo: titleBlockView.bottomAnchor,constant: 24),
            infoBlockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoBlockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoBlockView.heightAnchor.constraint(equalToConstant: 162)
               ])
        //locationBlockView
        NSLayoutConstraint.activate([
           locationBlockView.topAnchor.constraint(equalTo: infoBlockView.bottomAnchor,constant: 24),
            locationBlockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            locationBlockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            locationBlockView.heightAnchor.constraint(equalToConstant: 144)
               ])
        //episodesBlockView
        NSLayoutConstraint.activate([
            episodesBlockView.topAnchor.constraint(equalTo: locationBlockView.bottomAnchor),
            episodesBlockView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            episodesBlockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            episodesBlockView.heightAnchor.constraint(equalToConstant: 22)
           // episodesBlockView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
               ])
        //charecterImageView
        NSLayoutConstraint.activate([
            charecterImageView.centerXAnchor.constraint(equalTo: titleBlockView.centerXAnchor),
            charecterImageView.topAnchor.constraint(equalTo: titleBlockView.topAnchor, constant: 16),
            charecterImageView.widthAnchor.constraint(equalToConstant: 148),
            charecterImageView.heightAnchor.constraint(equalToConstant: 148)
               ])
        //titleLabel
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: titleBlockView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: charecterImageView.bottomAnchor, constant: 24),
//            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleBlockView.leadingAnchor, constant: 24),
//            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: titleBlockView.trailingAnchor, constant: 24)
               ])
        //statusLabel
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: titleBlockView.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
               ])
        //infoLabel
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: infoBlockView.topAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: infoBlockView.leadingAnchor, constant: 24),
            infoLabel.heightAnchor.constraint(equalToConstant: 22)
               ])
        //infoTableView
        NSLayoutConstraint.activate([
            infoTableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor,constant: 16),
            infoTableView.leadingAnchor.constraint(equalTo: infoBlockView.leadingAnchor, constant: 24),
        infoTableView.trailingAnchor.constraint(equalTo: infoBlockView.trailingAnchor, constant: -24),
            infoTableView.heightAnchor.constraint(equalToConstant: 124)
           ])
        //infoTableViewCells
        NSLayoutConstraint.activate([
            infoTableViewCells[0].topAnchor.constraint(equalTo: infoTableView.topAnchor),
            infoTableViewCells[0].centerXAnchor.constraint(equalTo: infoTableView.centerXAnchor),
            infoTableViewCells[1].topAnchor.constraint(equalTo: infoTableViewCells[0].bottomAnchor),
            infoTableViewCells[1].centerXAnchor.constraint(equalTo: infoTableView.centerXAnchor),
            infoTableViewCells[2].topAnchor.constraint(equalTo: infoTableViewCells[1].bottomAnchor),
            infoTableViewCells[2].centerXAnchor.constraint(equalTo: infoTableView.centerXAnchor)
        ])
        //locationLabel
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: locationBlockView.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationBlockView.leadingAnchor, constant: 24)
               ])
        //locationView
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor,constant: 16),
            locationView.leadingAnchor.constraint(equalTo: locationBlockView.leadingAnchor,constant: 24),
            locationView.trailingAnchor.constraint(equalTo: locationBlockView.trailingAnchor,constant: -24),
            locationView.heightAnchor.constraint(equalToConstant: 80)
               ])
        //locationBackgroundImageView
        NSLayoutConstraint.activate([
            locationBackgroundImageView.leadingAnchor.constraint(equalTo: locationView.leadingAnchor,constant: 8),
            locationBackgroundImageView.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            locationBackgroundImageView.heightAnchor.constraint(equalToConstant: 64),
            locationBackgroundImageView.widthAnchor.constraint(equalToConstant: 64)
               ])
        //nameOfOrigin
        NSLayoutConstraint.activate([
            nameOfOrigin.topAnchor.constraint(equalTo: locationView.topAnchor,constant: 16),
            nameOfOrigin.leadingAnchor.constraint(equalTo: locationBackgroundImageView.trailingAnchor,constant: 16)
               ])
        //typeOfOrigin
        NSLayoutConstraint.activate([
            typeOfOrigin.topAnchor.constraint(equalTo: nameOfOrigin.bottomAnchor, constant: 8),
            typeOfOrigin.leadingAnchor.constraint(equalTo: locationBackgroundImageView.trailingAnchor,constant: 16)
               ])
        //locationImageView
        NSLayoutConstraint.activate([
            locationImageView.centerYAnchor.constraint(equalTo: locationBackgroundImageView.centerYAnchor),
            locationImageView.centerXAnchor.constraint(equalTo: locationBackgroundImageView.centerXAnchor),
            locationImageView.heightAnchor.constraint(equalToConstant:24),
            locationImageView.widthAnchor.constraint(equalToConstant: 24)
               ])
        //episodesLabel
        NSLayoutConstraint.activate([
            episodesLabel.topAnchor.constraint(equalTo: episodesBlockView.topAnchor),
            episodesLabel.leadingAnchor.constraint(equalTo: episodesBlockView.leadingAnchor, constant: 24)
               ])
        //episodesCollectionView
        NSLayoutConstraint.activate([
            episodesCollectionView.topAnchor.constraint(equalTo: episodesBlockView.bottomAnchor,constant: 16),
            episodesCollectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            episodesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            episodesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            episodesCollectionViewHeightConstraint,
            episodesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
           ])
       
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleBlockView.translatesAutoresizingMaskIntoConstraints = false
        infoBlockView.translatesAutoresizingMaskIntoConstraints = false
        locationBlockView.translatesAutoresizingMaskIntoConstraints = false
        episodesBlockView.translatesAutoresizingMaskIntoConstraints = false
        charecterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationView.translatesAutoresizingMaskIntoConstraints = false
        locationBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        nameOfOrigin.translatesAutoresizingMaskIntoConstraints = false
        typeOfOrigin.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        episodesLabel.translatesAutoresizingMaskIntoConstraints = false
        episodesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        infoTableViewCells[0].translatesAutoresizingMaskIntoConstraints = false
        infoTableViewCells[1].translatesAutoresizingMaskIntoConstraints = false
        infoTableViewCells[2].translatesAutoresizingMaskIntoConstraints = false
          }
      }
