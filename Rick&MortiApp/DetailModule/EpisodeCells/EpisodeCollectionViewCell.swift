//
//  EpisodeCollectionViewCell.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "EpisodeCell"
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var number: String = "" {
        didSet {
            numberLabel.text = parsStr(str: number)
        }
    }
    var dateCreation: String = "" {
        didSet {
            dateLabel.text = dateCreation
        }
    }
    // MARK: - Private Properties
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor(named: "greenTextColor")
        return label
    }()
    private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17)
        return label
        }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "darkGrayTextColor")
        return label
    }()
    
    // MARK: - Life Cycles Methods
       override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }

       required init?(coder: NSCoder) {
           fatalError()
       }
    
    // MARK: - Parse String Episode
    private func parsStr(str: String) -> String {
        if let seasonRange = str.range(of: "S"),
           let episodeRange = str.range(of: "E"),
           let season = Int(str[seasonRange.upperBound..<episodeRange.lowerBound]),
           let episode = Int(str[episodeRange.upperBound...]) {
            let result = "Episode: \(episode), Season: \(season)"
            return result // "Episode: 3, Season: 1"
        }
        return str
    }
    
    // MARK: - SetUpUI, Constrains
       private func setup() {
           backgroundColor = UIColor(named: "cellBackgroundColor")
           layer.cornerRadius = 16
           
           contentView.addSubview(dateLabel)
           contentView.addSubview(numberLabel)
           contentView.addSubview(titleLabel)
           
         
           
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.25),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -15.25)
           ])
           
           numberLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15.25)
                   ])

           dateLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.68),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: numberLabel.trailingAnchor, constant: 10)
                   ])
           
       }

}
