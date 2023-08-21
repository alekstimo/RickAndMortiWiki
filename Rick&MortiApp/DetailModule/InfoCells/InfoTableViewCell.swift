//
//  InfoTableViewCell.swift
//  Rick&MortiApp
//
//  Created by Александра Тимонова on 20.08.2023.
//

import UIKit

class InfoTableViewCell: UIView {

   
    // MARK: - Properties
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var info: String = "" {
        didSet {
            infoLabel.text = info
        }
    }
    // MARK: - Private Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "grayTextColor")
        return label
    }()
    // MARK: - Life Cycles Methods
    override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI, SetupConstraints
    private func setUp() {
        self.backgroundColor = UIColor(named: "cellBackgroundColor")
        
        self.addSubview(infoLabel)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 41.3),
            self.widthAnchor.constraint(equalToConstant: 327)
        ])
      
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            infoLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor,constant: 10),
            infoLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
                ])
        
        
    }
   

}
