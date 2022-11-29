//
//  NewsCell.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/29/22.
//

import Foundation
import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    lazy var image: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        return imgView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var location: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var user: UILabel = {
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
       
        addSubview(image)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(location)
        stack.addArrangedSubview(user)
        addSubview(stack)
        NSLayoutConstraint.activate([
            
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leftAnchor.constraint(equalTo: safeLeftAnchor, constant: 10),
            image.rightAnchor.constraint(equalTo: stack.leftAnchor, constant: 10),
            stack.topAnchor.constraint(equalTo: safeTopAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: safeRightAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: safeBottomAnchor,constant: -10)
        ])
    }
    
    func setupCell(data: NewsModelData) {
        if data.multiMedia.count > 0 {
            image.sd_setImage(with: URL(string: data.multiMedia[0].url))
        } else {
            image.image = UIImage(named: "no_image")
        }
        title.text = data.title ?? " "
        location.text = data.location
        user.text = data.user.name
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
