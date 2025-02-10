//
//  GuideMenuTableViewCell.swift
//  CJListDemo-Swift
//
//  Created by qian on 2025/2/10.
//

import UIKit
import CQDemoKit

import UIKit

class GuideMenuTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let guideLineView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
        view.isHidden = true  // 默认隐藏
        return view
    }()
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        return label
    }()
    
    var showBottomLine: Bool = false {
        didSet {
            guideLineView.isHidden = !showBottomLine
        }
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        showBottomLine = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        layer.masksToBounds = true
        showBottomLine = selected
        
        if selected {
            mainTitleLabel.textColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
        } else {
            mainTitleLabel.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        }
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(guideLineView)
        contentView.addSubview(myImageView)
        contentView.addSubview(mainTitleLabel)
        
        guideLineView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            guideLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            guideLineView.widthAnchor.constraint(equalToConstant: 4),
            guideLineView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            guideLineView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            myImageView.leadingAnchor.constraint(equalTo: guideLineView.trailingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            mainTitleLabel.leadingAnchor.constraint(equalTo: guideLineView.trailingAnchor, constant: 14.0),
            mainTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14.0),
            mainTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
