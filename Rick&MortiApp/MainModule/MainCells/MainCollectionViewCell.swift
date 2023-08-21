//
//  MainCollectionViewCell.swift
//  Rick&MortiApp
//
//  Created by Кирилл Зезюков on 20.08.2023.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    //MARK: -- Properties
    var image: String = "" {
        didSet {
            guard let url = URL(string: image) else {
                return
            }
            imageView.loadImage(from: url)
        }
    }
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    static let reuseIdentifier = "MainCell"
    
    //MARK: -- Private Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17)
        return label
        }()
    
    //MARK: --  Life Cycles Methods
       override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }

       required init?(coder: NSCoder) {
           fatalError()
       }
    // MARK: - SetupUI, SetupConstraints
       private func setup() {
           backgroundColor = UIColor(named: "cellBackgroundColor")
           layer.cornerRadius = 16
           
           contentView.addSubview(imageView)
           contentView.addSubview(titleLabel)
           
           //ImageView
           imageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140)
                   ])
           //Title Label
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -10)
           ])

           
       }

      
}
