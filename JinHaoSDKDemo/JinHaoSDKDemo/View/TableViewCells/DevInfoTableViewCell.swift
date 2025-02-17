//
//  DevInfoTableViewCell.swift
//  Euphony
//
//  Created by Anthony Benitez on 2/15/22.
//

import UIKit

class DevInfoTableViewCell: UITableViewCell {

    // MARK: - Properties
    /// Constants
    static let reuseIdentifier = String(describing: DevInfoTableViewCell.self)
    static let cellHeight: CGFloat = 40
    static let labelHeight: CGFloat = 16
    
    /// Stored Properties
    var titleText: String
    var detailText: String
    
    /// UI Properties
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkText
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.titleText = "???"
        self.detailText = "???"
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    /// UI Methods
    private func configureUI() {
        let containerView = UIView()
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 8,
                             paddingLeft: 8,
                             paddingBottom: 8,
                             paddingRight: 8)
        
        containerView.addSubview(titleLabel)
        titleLabel.setDimensions(width: 150, height: Self.labelHeight)
        titleLabel.centerY(inView: containerView)
        titleLabel.anchor(left: containerView.leftAnchor,
                          paddingLeft: 8)

        
        containerView.addSubview(detailLabel)
        detailLabel.centerY(inView: containerView)
        detailLabel.anchor(left: titleLabel.rightAnchor,
                           right: containerView.rightAnchor,
                           paddingLeft: 8,
                           paddingRight: 8,
                           height: Self.labelHeight)
        
    }
    
    /// Helper Methods
    public func configureData(titleText: String, detailText: String) {
        titleLabel.text = titleText
        detailLabel.text = detailText
    }

}

