//
//  UserEmailCell.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/29/22.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
  
    lazy var touristName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var touristLocation: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var touristEmail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalSpacing
        sv.alignment = UIStackView.Alignment.center
        sv.spacing   = 16.0
        return sv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        stack.addArrangedSubview(touristName)
        stack.addArrangedSubview(touristLocation)
        stack.addArrangedSubview(touristEmail)
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: safeLeftAnchor,constant: 10),
            stack.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: safeRightAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: safeBottomAnchor,constant: -10)
        ])
    }
    
    func setupCell(data: UsersModelData) {
        touristName.text = data.touristName
        touristLocation.text = data.touristLocation
        touristEmail.text = data.touristEmail
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
