//
//  CategoryViewCellTableViewCell.swift
//  SimplyDo
//
//  Created by Rauf Aliyev on 03.01.22.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    var hStask : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let cellLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
       return label
    }()
    
    var cellImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLabelConstraints()
        setupImageViewConstraints()
        setupHStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHStack(){
        addSubview(hStask)
        
        NSLayoutConstraint.activate([
            hStask.topAnchor.constraint(equalTo: topAnchor),
            hStask.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            hStask.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStask.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupCellLabelConstraints(){
        self.hStask.addArrangedSubview(cellLabel)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: hStask.topAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: hStask.leadingAnchor, constant: 10),
            cellLabel.trailingAnchor.constraint(equalTo: hStask.trailingAnchor, constant: -60),
            cellLabel.bottomAnchor.constraint(equalTo: hStask.bottomAnchor)
        ])
    }
    
        func setupImageViewConstraints(){
            self.hStask.addArrangedSubview(cellImage)
            cellImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                cellImage.topAnchor.constraint(equalTo: hStask.topAnchor),
                cellImage.trailingAnchor.constraint(equalTo: hStask.trailingAnchor, constant: -15),
                cellImage.leadingAnchor.constraint(equalTo: cellLabel.trailingAnchor, constant: 32),
                cellImage.bottomAnchor.constraint(equalTo: hStask.bottomAnchor)
            ])
        }
}
